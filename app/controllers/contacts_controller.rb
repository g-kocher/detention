class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = 'Thanks for your message!'
      render :root
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end

end
