class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :salt, :string
  end
end
