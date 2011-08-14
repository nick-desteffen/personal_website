class ContactMessagesController < ApplicationController
  
  before_filter :set_active_tab

  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(params[:contact_message])
    @contact_message.user_agent = request.user_agent
    
    if @contact_message.save
      redirect_to root_path, :notice => "Thanks! I'll be in touch soon!"
    else
      flash.now[:alert] = "There was an error. Please correct the fields."
      render :action => :new
    end
    
  end

  private
  
  def set_active_tab
    @active_tab = :contact
  end
  
end
