class AlertMailer < ActionMailer::Base
  default from: ENV['DEFAULT_FROM_EMAIL']

  def data_update_email items_created
    @products = Product.recent(items_created)
    @companies = @products.includes(:company).map{|p| p.company }.uniq
    mail(bcc: email_list, subject: "FDA Import Alert Update")
  end

  def email_list
    User.active.map{|user| user.email }
  end
end
