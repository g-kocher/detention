require 'rails_helper'

RSpec.describe AlertsController, :type => :controller do

  describe "GET pesticides" do
    it "returns http success" do
      get :pesticides
      expect(response).to be_success
    end
  end

end
