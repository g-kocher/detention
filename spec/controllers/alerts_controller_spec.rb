require 'rails_helper'

RSpec.describe AlertsController, :type => :controller do
  describe "GET pesticides" do
    before(:each) { get :pesticides }
    it "returns http success" do
      expect(response).to be_success
    end
    it 'returns @products' do
      expect(@products).to_not be_nil
    end
  end

end
