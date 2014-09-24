class ProductsController < ApplicationController
  def show
    @product = Product.includes(:company, :pesticides).find(params[:id])
    @related_products = Product.where(company_id: @product.company_id).where.not(id: @product.id).order(date_published: :desc)
  end
end
