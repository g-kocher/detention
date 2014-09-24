class AlertsController < ApplicationController
  def pesticides
    @companies = Company.includes(:products).order('products.date_published DESC').where("products.date_published BETWEEN '#{Date.today - 1.month}' AND '#{Date.today}'")
  end
end