module ApplicationHelper
  def format_product_name name
    name.gsub(/([0-9]{2}\W[A-Z,-]\W[A-Z,-]\W[A-Z,-]\W[0-9,-]{2}\W\W)/, "")
  end
  def format_address address
    address.gsub(",", '<br />').html_safe
  end
  def last_published company
    company.products.map {|product| product.date_published}.max.strftime("%m/%d/%Y")
  end
end
