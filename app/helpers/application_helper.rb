module ApplicationHelper
  
  def error_messages_for(object)
    render :partial => "shared/error_messages", :object => object
  end
  
  def gravatar_image(gravatar_hash, options={})
    return if gravatar_hash.blank?
    size = options[:size] || 75
    alt = options[:alt] || ""
    title = options[:title] || ""
    image_tag("http://www.gravatar.com/avatar/#{gravatar_hash}?size=#{size}", :alt => alt, :title => title)
  end
  
  def format_timestamp(timestamp)
    return if timestamp.blank?
    timestamp.strftime("%m/%d/%Y %I:%M%p").downcase
  end
  
  def navigation_class(navigation_key)
    return "" unless defined?(@active_tab)
    return "active" if navigation_key == @active_tab
    return ""
  end
  
end
