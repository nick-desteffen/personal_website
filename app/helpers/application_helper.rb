module ApplicationHelper
  
  def error_messages_for(object)
    return if object.nil? || object.errors.empty?
    errors = object.errors
    header_message = pluralize(errors.size, "error") + (errors.size > 1 ? " require" : " requires") + " your attention"
    content_tag(:div, :class => "form_errors") do
      concat(content_tag(:h2, header_message))
      concat(content_tag(:ul) do
        errors.each do |message|
          concat(content_tag(:li, message))
        end
      end)
    end
  end

  def flash_messages
    return if flash.empty?
    html = ""
    flash.each do |key, value|
      html += content_tag(:div, content_tag(:p, (content_tag(:span, value) + link_to(image_tag("icons/black/24x24/error.png"), "#", class: "close").html_safe), class: key), class:  "flash-messages #{key}")
    end
    return html.html_safe
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
