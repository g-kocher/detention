require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do

  let(:product) {FactoryGirl.create(:product)}

  describe "GET show" do
    before(:each) { get :show, id: product }
    it "returns http success" do
      expect(response).to be_success
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end
end
