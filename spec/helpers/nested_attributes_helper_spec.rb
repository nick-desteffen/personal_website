require 'spec_helper'

describe NestedAttributesHelper do

  describe "link_to_remove_fields" do
    it "returns a hidden field with the _destroy paramter and a link that calls the remove_fields function" do
      post = FactoryGirl.create(:post)
      tag = FactoryGirl.create(:tag, :post => post)
      link = ""
      form_for(post, :url => update_post_path(post)) do |form|
        form.fields_for :tags do |tag_fields|
          link = helper.link_to_remove_fields("remove", tag_fields)
        end
      end

      link.should == "<input id=\"post_tags_attributes_0__destroy\" name=\"post[tags_attributes][0][_destroy]\" type=\"hidden\" value=\"false\" /><a href=\"#\" data-destroy=\"true\">remove</a><input id=\"post_tags_attributes_0_id\" name=\"post[tags_attributes][0][id]\" type=\"hidden\" value=\"#{tag.id}\" />"
    end
  end

  describe "link_to_add_fields" do
    it "returns a link to add nested attribute fields and inserts the template and click bindings in the javascript block" do
      post = FactoryGirl.create(:post)
      tag = FactoryGirl.create(:tag, :post => post)
      link = ""
      helper.should_receive(:content_for).with(:javascript)

      form_for(post, :url => update_post_path(post)) do |form|
        form.fields_for :tags do |tag_fields|
          link = helper.link_to_add_fields("My Link", :tags, form)
        end
      end
      link.should == "<a href=\"#\" data-add-tags=\"true\">My Link</a><input id=\"post_tags_attributes_0_id\" name=\"post[tags_attributes][0][id]\" type=\"hidden\" value=\"#{tag.id}\" />"
    end
  end

  describe "nested_attributes_form_template" do
    it "returns the nested attribute form template" do
      post = FactoryGirl.create(:post)
      tag = FactoryGirl.create(:tag, :post => post)
      template = ""
      form_for(post, :url => update_post_path(post)) do |form|
        form.fields_for :tags do |tag_fields|
          template = helper.send(:nested_attributes_form_template, :tags, form)
        end
      end

      template.should == "<div class=\\\"fields\\\">\\n  <label for=\\\"post_tags_attributes_new_tags_name\\\">Name<\\/label>\\n  <input id=\\\"post_tags_attributes_new_tags_name\\\" name=\\\"post[tags_attributes][new_tags][name]\\\" size=\\\"30\\\" type=\\\"text\\\" />\\n  <br />\\n  <input id=\\\"post_tags_attributes_new_tags__destroy\\\" name=\\\"post[tags_attributes][new_tags][_destroy]\\\" type=\\\"hidden\\\" value=\\\"false\\\" /><a href=\\\"#\\\" data-destroy=\\\"true\\\">remove<\\/a>\\n<\\/div><input id=\"post_tags_attributes_0_id\" name=\"post[tags_attributes][0][id]\" type=\"hidden\" value=\"#{tag.id}\" />"
    end
  end

end
