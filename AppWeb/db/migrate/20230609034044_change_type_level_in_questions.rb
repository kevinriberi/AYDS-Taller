class ChangeTypeLevelInQuestions < ActiveRecord::Migration[7.0]
  def change
    change_column :questions, :level, :integer
  end
end
