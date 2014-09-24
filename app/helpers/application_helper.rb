module ApplicationHelper
  def format_product_name name
    name.gsub(/([0-9]{2}\W[A-Z,-]\W[A-Z,-]\W[A-Z,-]\W[0-9,-]{2}\W\W)/, "")
  end
  def format_address address
    address.gsub(",", '<br />').html_safe
  end
end
