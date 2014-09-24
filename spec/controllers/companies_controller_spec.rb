require 'rails_helper'

RSpec.describe CompaniesController, :type => :controller do

  let(:company) {FactoryGirl.create(:company)}

  describe "GET show" do
    before(:each) { get :show, id: company }
    it "returns http success" do
      expect(response).to be_success
    end
    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end

end
