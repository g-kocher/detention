class AddCounterCacheToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :products_count, :integer
    Company.all.each do |company|
      company.update_attribute(:products_count, company.products.length)
    end
  end
end
