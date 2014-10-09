class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_parameters)
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = 'Thanks for your message!'
      render :root
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end

  private
  def contact_parameters
    params.require(:contact).permit(:name, :email, :message)
  end

end
