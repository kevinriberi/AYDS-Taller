class ChangeDataTypeOfTimeInAnswers < ActiveRecord::Migration[7.0]
  def change
    change_column :answers, :time, :integer, default: 0
  end
end
