class AddRequestToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :request, :text
  end
end
