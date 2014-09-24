class CompaniesController < ApplicationController
  def show
    @company = Company.find(params[:id])
    @products = Product.where(company_id: @company)
  end
end
