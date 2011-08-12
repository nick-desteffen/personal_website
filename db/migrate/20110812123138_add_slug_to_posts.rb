class AddSlugToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :cached_slug, :string
  end
end
