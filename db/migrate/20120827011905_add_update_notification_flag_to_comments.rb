class AddUpdateNotificationFlagToComments < ActiveRecord::Migration
  def change
    add_column :comments, :new_comment_notification, :boolean, default: false
  end
end
