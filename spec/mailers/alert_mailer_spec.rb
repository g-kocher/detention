require "rails_helper"
require 'faker'

RSpec.describe AlertMailer, :type => :mailer do

  describe 'data_update_email' do 
    let( :product ) { FactoryGirl.create :product }
    let( :active_user ) { FactoryGirl.create :user }
    let( :inactive_user ) { FactoryGirl.create :user, active: false }
    let( :test_email ) { ActionMailer::Base.deliveries }

    before( :each ) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      @product_updates = [ product.id ]
      AlertMailer.data_update_email( @product_updates ).deliver
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it 'sends an email' do
      expect(test_email.count).to eq 1
    end

    it 'sends the email from the right address' do
      expect(test_email.first.from).to eq ["test@FDAImportAlerts.info"]
    end

    it 'sends the email to only active users' do
      expect(test_email.first.bcc).to eq ['email@example.com']
    end

    describe 'email body' do
      let(:body) { test_email[-1].body.to_s }

      it 'contains the title' do
        title = "Import Alert List has been updated"
        expect(body).to have_xpath(
          "//header/h1[contains(.,'#{ title }')]"
          )
      end

      it 'contains the company name' do
        expect(body).to have_xpath(
        "//div[@class='company']/a[contains(.,'#{ product.company.name }')]"
        )
      end

      it 'has the compnay address' do
        formatted_address = product.company.address.gsub(",", '')
        expect(body).to have_content( formatted_address )
      end

      it 'contains the product' do
        expect(body).to have_xpath(
          "//div/div[@class='company-products'][contains(.,'#{ product.name }')]"
          )
      end
    end
  end
end
