class AlertMailer < ActionMailer::Base

  def data_update_email product_ids_updated
    @products = Product.includes(:company).find(product_ids_updated).map{ |p| p }
    @companies = @products.map{ |product| product.company }
    mail(bcc: email_list, subject: "FDA Import Alert Update", content_type: 'text/html')
  end

  private
  def email_list
    User.active.select(:email).map{ |user| user.email }
  end
end
