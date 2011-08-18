class UpdateFriendlyId < ActiveRecord::Migration
  def up
    drop_table :slugs
    rename_column :posts, :cached_slug, :slug
    add_index :posts, :slug, :unique => true
  end

  def down
  end
end
