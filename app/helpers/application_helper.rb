module ApplicationHelper
  
  def error_messages_for(object)
    render :partial => "shared/error_messages", :object => object
  end
  
end
