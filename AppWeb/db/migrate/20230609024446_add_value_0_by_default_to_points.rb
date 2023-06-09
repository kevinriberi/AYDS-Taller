class AddValue0ByDefaultToPoints < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :points, from: nil, to: 0
  end
end
