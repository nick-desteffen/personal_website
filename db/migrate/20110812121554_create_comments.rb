class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.string :name
      t.string :email
      t.text :body
      t.string :url
      t.string :gravatar_url

      t.timestamps
    end
  end
end
