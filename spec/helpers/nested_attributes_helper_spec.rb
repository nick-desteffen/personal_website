require 'spec_helper'

describe NestedAttributesHelper do

  let(:post) { FactoryGirl.create(:post) }
  let!(:related_link) { FactoryGirl.create(:related_link, post: post) }

  describe "link_to_remove_fields" do
    it "returns a hidden field with the _destroy paramter and a link that calls the remove_fields function" do
      link = ""
      form_for(post, url: update_post_path(post)) do |form|
        form.fields_for :related_links do |related_link_fields|
          link = helper.link_to_remove_fields("remove", related_link_fields)
        end
      end

      expect(link).to eq "<input id=\"post_related_links_attributes_0__destroy\" name=\"post[related_links_attributes][0][_destroy]\" type=\"hidden\" value=\"false\" /><a data-destroy=\"true\" href=\"#\">remove</a><input id=\"post_related_links_attributes_0_id\" name=\"post[related_links_attributes][0][id]\" type=\"hidden\" value=\"#{related_link.id}\" />"
    end
  end

  describe "link_to_add_fields" do
    it "returns a link to add nested attribute fields and inserts the template and click bindings in the javascript block" do
      link = ""
      allow(helper).to receive(:content_for).with(:javascript)

      form_for(post, url: update_post_path(post)) do |form|
        form.fields_for :related_links do |related_link_fields|
          link = helper.link_to_add_fields("My Link", :related_links, form)
        end
      end

      expect(link).to eq "<a data-add-related-links=\"true\" href=\"#\">My Link</a><input id=\"post_related_links_attributes_0_id\" name=\"post[related_links_attributes][0][id]\" type=\"hidden\" value=\"#{related_link.id}\" />"
    end
  end

  describe "nested_attributes_form_template" do
    it "returns the nested attribute form template" do
      template = ""
      form_for(post, url: update_post_path(post)) do |form|
        form.fields_for :related_links do |related_link_fields|
          template = helper.send(:nested_attributes_form_template, :related_links, form)
        end
      end

      expect(template).to eq "<div class=\\\"fields\\\">\\n  <label for=\\\"post_related_links_attributes_new_related_links_title\\\">Title<\\/label>\\n  <input id=\\\"post_related_links_attributes_new_related_links_title\\\" name=\\\"post[related_links_attributes][new_related_links][title]\\\" type=\\\"text\\\" />\\n  <label for=\\\"post_related_links_attributes_new_related_links_url\\\">Url<\\/label>\\n  <input id=\\\"post_related_links_attributes_new_related_links_url\\\" name=\\\"post[related_links_attributes][new_related_links][url]\\\" type=\\\"url\\\" />\\n  <br />\\n  <input id=\\\"post_related_links_attributes_new_related_links__destroy\\\" name=\\\"post[related_links_attributes][new_related_links][_destroy]\\\" type=\\\"hidden\\\" value=\\\"false\\\" /><a data-destroy=\\\"true\\\" href=\\\"#\\\">remove<\\/a>\\n<\\/div><input id=\"post_related_links_attributes_0_id\" name=\"post[related_links_attributes][0][id]\" type=\"hidden\" value=\"#{related_link.id}\" />"
    end
  end

end
