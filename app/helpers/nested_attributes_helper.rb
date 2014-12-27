module NestedAttributesHelper

  def link_to_remove_fields(title, form)
    link = form.hidden_field(:_destroy) + link_to(title, "#", data: {destroy: 'true'})
    return link
  end

  def link_to_add_fields(title, association, form)
    data_attributes = {}
    data_attributes["add-#{association.to_s.dasherize}"] = "true"
    content_for :javascript do
      javascript_tag do
        "var #{association}_form_template = '#{nested_attributes_form_template(association.to_s.pluralize.to_sym, form)}';".html_safe +
        "$('body').on('click', 'a[data-add-#{association.to_s.dasherize}=\"true\"]', function(link){add_fields(link.currentTarget, '#{association.to_s.pluralize}', #{association}_form_template); return false;});".html_safe
      end
    end
    link_to(title, "#", data: data_attributes)
  end

  private

  def nested_attributes_form_template(association, form)
    new_object = form.object.class.reflect_on_association(association).klass.new
    fields = form.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(form.object.class.name.pluralize.downcase + "/" + association.to_s.singularize + "_fields", :form => builder)
    end
    return escape_javascript(fields)
  end

end
