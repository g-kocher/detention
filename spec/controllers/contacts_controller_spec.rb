require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  describe 'GET new' do
    before(:each) { get :new }
    it 'returns a success' do
      expect(response).to be_success
    end
    it 'renders the new contact form' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do 
    context 'when the form is correctly submitted' do
      render_views
      before(:each) do
        visit new_contact_path
        fill_in 'Name', with: 'garrett'
        fill_in 'Email Address', with: 'email@example.com'
        fill_in 'Message', with: 'a message'
        click_button 'Send message'
      end

      it 'returns a success' do
        expect(response).to be_success
      end

      it 'renders the root' do
        expect(response).to render_template('welcome/index')
      end

    end

    context 'when the email is missing' do
      render_views
      before(:each) do
        visit new_contact_path
        fill_in 'Email Address', with: 'email@example.com'
        fill_in 'Message', with: 'a message'
        click_button 'Send message'
      end

      it 'gives a 400 status' do
        expect(page).to have_http_status(:bad_request)
      end

      it 'renders the contact form' do
        expect(page).to render_template('new')
      end
    end
  end
end
