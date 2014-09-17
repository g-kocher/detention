require 'rails_helper'

RSpec.describe Company, :type => :model do

  let(:company) { Company.new(name: "Acme Foods", address: "321 21st Ave Seattle, WA 98122, United States" )}

  describe 'basic model' do
    it { expect(company).to validate_presence_of   :name }
    it { expect(company).to validate_uniqueness_of   :name }

    it { expect(company).to validate_presence_of   :address}
  end

  describe 'methods' do
    it { should respond_to(:name) }
    it { should respond_to(:address) }
    it { should respond_to(:products) }
    it { should respond_to(:phone) }
    it { should respond_to(:contact) }
  end

end
