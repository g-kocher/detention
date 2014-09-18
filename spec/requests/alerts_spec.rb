require 'spec_helper'

describe 'Pesticides' do
  describe "GET /alerts/pesticides" do
    before(:each) do 
      visit "/alerts/pesticides"
    end
    it 'renders' do
      expect(page.status_code).to eq 200
    end
    it 'has the Pesticides Alerts title' do
      expect(page).to have_selector 'h1', 'Pesticides Alerts'
    end
    it 'has the subtitle 99-08' do
      expect(page).to have_selector 'h3', '99-08'
    end
  end
end