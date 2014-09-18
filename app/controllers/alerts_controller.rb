class AlertsController < ApplicationController
  def pesticides
    @products = Product.order('date(date_published) DESC').limit(10)
  end
end
