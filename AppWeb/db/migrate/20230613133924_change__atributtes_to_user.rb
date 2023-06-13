class ChangeAtributtesToUser < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :email, :username
    rename_column :users, :firstname, :name
    remove_column :users, :lastname
  end
end
