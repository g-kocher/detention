require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do
  render_views
  describe "GET index" do
    before(:each) { get :index }
    it "returns http success" do
      expect(response).to be_success
    end
  end

  describe 'GET sitemap' do
    before(:each) { get :sitemap }
    it 'returns http success' do
      expect(response).to be_success
    end

    it 'returns xml sitemap index' do
      expect(response.body.to_s).to include('sitemapindex')
    end
  end

end
