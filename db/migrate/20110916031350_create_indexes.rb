class CreateIndexes < ActiveRecord::Migration
  def up
    add_index :comments, :post_id
    add_index :related_links, :post_id
    add_index :tags, :post_id
    add_index :users, :email
  end

  def down
  end
end
