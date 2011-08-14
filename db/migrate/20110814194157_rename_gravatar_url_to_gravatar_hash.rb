class RenameGravatarUrlToGravatarHash < ActiveRecord::Migration
  def up
    rename_column :comments, :gravatar_url, :gravatar_hash
  end

  def down
    rename_column :comments, :gravatar_hash, :gravatar_url
  end
end
