require 'spec_helper'

describe 'Index Page' do
  describe "GET /" do
    before(:each) do 
      visit "/"
    end
    it 'renders' do
      expect(page.status_code).to eq 200
    end
    it 'has a title' do
      expect(page).to have_selector 'h1', text: 'FDA Import Alert Notifications'
    end

    it 'has a link to the FDA website' do
      expect(page).to have_link "", "http://www.fda.gov/ForIndustry/ImportProgram/ImportAlerts/"
    end

  end
end