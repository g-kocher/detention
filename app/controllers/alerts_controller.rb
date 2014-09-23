class AlertsController < ApplicationController
  def pesticides
    @companies = Company.includes(:products).order('products.date_published DESC').limit(200)

  end
end