class ChangeColumnTypeInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :points, :float, :default => 0
  end
end
