class Import < ActiveRecord::Base
  validates :items_created, presence: true

  def refresh data=client.fetch
    site_data = data
    new_products_ids = create_records_from site_data
    save
    if new_products_ids.count > 0
      send_mail new_products_ids
    end
  end

  private
  def send_mail product_ids_updated
    AlertMailer.data_update_email( product_ids_updated ).deliver
  end

  def client
    FDA::Detention::Client.new('http://www.accessdata.fda.gov/cms_ia/importalert_259.html')
  end

  def create_records_from(data)
    new_products = []
    data.each do |comp|
      company = Company.where(name: comp[:name], address: comp[:address]).first_or_create
      comp[:products].each do |prod|
        product = Product.where(company_id: company.id, name: prod[:name]).first_or_create do |product|
          product.date_published = prod[:date]
          new_products << product.id
        end
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
