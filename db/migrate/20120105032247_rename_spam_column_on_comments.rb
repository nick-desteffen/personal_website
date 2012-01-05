class RenameSpamColumnOnComments < ActiveRecord::Migration
  def up
  	rename_column :comments, :spam, :spam_flag
  end

  def down
  	rename_column :comments, :spam_flag, :spam
  end
end
