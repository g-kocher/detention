class Import < ActiveRecord::Base
  validates :items_created, presence: true

  def refresh data=client.fetch
    initial_product_count = Product.count
    site_data = data
    create_records_from site_data
    self.items_created = Product.count - initial_product_count
    self.save
  end

  private
  def client
    FDA::Detention::Client.new('http://www.accessdata.fda.gov/cms_ia/importalert_259.html')
  end

  def create_records_from(data)
    data.each do |comp|
      company = Company.where(name: comp[:name]).first_or_create {|r| r.address = comp[:address]}
      comp[:products].each do |prod|
        product = company.products.where(name: prod[:name]).first_or_create {|p| p.date_published = prod[:date]}
        unless prod[:pesticides].nil?
          prod[:pesticides].each do |pest|
            pesticide = Pesticide.where(name: pest).first_or_create
            problem = Problem.where(product_id: product.id, pesticide_id: pesticide.id).first_or_create
          end
        end
      end
    end
  end
end
