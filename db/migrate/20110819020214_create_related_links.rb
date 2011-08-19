class CreateRelatedLinks < ActiveRecord::Migration
  def change
    create_table :related_links do |t|
      t.integer :post_id
      t.string :title
      t.string :url
      t.timestamps
    end
  end
end
