module ApplicationHelper
  
  def error_messages_for(object)
    render :partial => "shared/error_messages", :object => object
  end
    
  def format_timestamp(timestamp)
    return if timestamp.blank?
    timestamp.strftime("%m/%d/%Y %I:%M%p").downcase
  end
  
  def format_date(timestamp)
    return if timestamp.blank?
    timestamp.strftime("%m/%d/%Y").downcase
  end
  
  def navigation_link(title, path, key)
    style_class = ""
    style_class = "active" if key == controller.active_tab
    link_to(title, path, :class => style_class)
  end
  
  def button(text, options={})
    type = options[:type] || :submit
    content_tag(:button, text, :class => "button", :type => type, :id => options[:id])
  end
  
  def page_title
    return "#{@page_title} | Nick DeSteffen" if defined?(@page_title)
    title = controller.active_tab.present? ? controller.active_tab.capitalize : nil
    return "#{title} | Nick DeSteffen" if title
    return "Nick DeSteffen"
  end
  
  def link_to_remove_fields(name, form)
    form.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, form, association)
    new_object = form.object.class.reflect_on_association(association).klass.new
    fields = form.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(form.object.class.name.pluralize.downcase + "/" + association.to_s.singularize + "_fields", :form => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
end
