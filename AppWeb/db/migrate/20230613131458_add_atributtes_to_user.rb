class AddAtributtesToUser < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :username, :email
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
  end
end
