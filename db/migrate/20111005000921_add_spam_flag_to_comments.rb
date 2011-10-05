class AddSpamFlagToComments < ActiveRecord::Migration
  def change
    add_column :comments, :spam, :boolean, :default => false
  end
end
