class AlertMailer < ActionMailer::Base
  default from: "g.kocher@gmail.com"

  def data_update_email items_created
    @products = Product.order(created_at: :desc).limit(items_created)
    @distribution_list = ['g.kocher@gmail.com', 'garrettresponse@gmail.com']
    mail(bcc: @distribution_list, subject: "FDA Import Alert Update")
  end


end
