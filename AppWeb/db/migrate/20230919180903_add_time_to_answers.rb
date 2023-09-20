class AddTimeToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :time, :float, default: 0
  end
end
