class CreateContactMessages < ActiveRecord::Migration
  def change
    create_table :contact_messages do |t|
      t.string :name
      t.string :email
      t.text :message
      t.string :user_agent
      t.string :subject
      t.string :phone_number

      t.timestamps
    end
  end
end
