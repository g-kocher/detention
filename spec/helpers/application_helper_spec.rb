require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  describe 'format product name' do
    it 'removes the codes from the beginning' do
      product_name = "20 B - - 10  Raisins,  Dried or Paste"
      expect( helper.format_product_name product_name ).to eq "Raisins,  Dried or Paste"
    end
  end

  describe 'format address' do
    it 'removes the comma and inserts a <br />' do
      address = "Charagh Ali Market, kabul, AF-KAB AFGHANISTAN"
      expect( helper.format_address address ).to eq "Charagh Ali Market<br /> kabul<br /> AF-KAB AFGHANISTAN"
    end
  end

  describe 'last published' do
    let( :company ) do
      FactoryGirl.create :company do |company|
        company.products.create(
          FactoryGirl.attributes_for :product, date_published: Date.new(2010,01,13)
          )
        company.products.create(
          FactoryGirl.attributes_for :product, date_published: Date.new(1999,12,31)
          )
      end
    end

    it 'selects the date of the most recent published product' do
      expect(helper.last_published company).to eq "01/13/2010"
    end

  end
end