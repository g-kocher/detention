require 'rails_helper'

RSpec.describe Product, :type => :model do

  let(:product) { Product.new(name: 'Weed', date: Date.new(2008,12,23)) }

  describe 'basic model' do
    it { expect(product).to validate_presence_of   :name }
    it { expect(product).to validate_presence_of   :date }
  end

  describe 'methods' do
    it { should respond_to(:name) }
    it { should respond_to(:date) }
    it { should respond_to(:problems) }
    it { should respond_to(:company) }
  end

end
