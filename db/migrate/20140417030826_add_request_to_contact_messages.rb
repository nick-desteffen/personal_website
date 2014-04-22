class AddRequestToContactMessages < ActiveRecord::Migration
  def change
    add_column :contact_messages, :spam_flag, :boolean, default: false
    add_column :contact_messages, :request, :text
  end
end
