class ContactMessagesController < ApplicationController
  
  active_tab :contact

  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(contact_message_params)
    @contact_message.user_agent = request.user_agent
    
    if @contact_message.save
      redirect_to root_path, :notice => "Thanks! I'll be in touch soon!"
    else
      flash.now.alert = "Please correct the highlighted fields and resubmit."
      render :action => :new
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:email, :name, :phone_number, :subject, :message)
  end
  
end
