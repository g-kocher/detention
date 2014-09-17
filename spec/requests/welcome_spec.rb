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
      expect(page).to have_selector 'h1', text: 'Welcome to FDA Import Alerts'
    end
    it 'requests users for email' do
      expect(page).to have_selector 'h3', text: 'Would email updates to the FDA alerts be useful to you?'
    end
    it 'has a link to the FDA website' do
      expect(page).to have_link "", "http://www.fda.gov/ForIndustry/ImportProgram/ImportAlerts/"
    end

  end
end