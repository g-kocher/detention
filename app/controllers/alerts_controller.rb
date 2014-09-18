class AlertsController < ApplicationController
  def pesticides
    @products = Product.order('date(date_published)').includes(:company, :pesticides)
    @product_months = @products.group_by {|p| p.date_published.beginning_of_month }
  end
end
