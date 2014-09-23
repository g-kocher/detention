class AlertMailer < ActionMailer::Base
  default from: "garrett@fdaimportalerts.info"

  def data_update_email(updated_items)
    @companies = Companies.joins(:products).order('products.date_updated DESC').limit(updated_items).includes(:products)
    @distribution_list = ['g.kocher@gmail.com', 'garrettresponse@gmail.com']
    mail(to: @distribution_list, subject: "FDA Import Alert Updated: #{updated_items} #{'item'.pluralize(updated_items)}")
  end


end
