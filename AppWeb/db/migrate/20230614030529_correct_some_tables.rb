class CorrectSomeTables < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :correct_option_id, :integer
    add_column :options, :correct, :boolean, default: false
    remove_column :answers, :correct, :boolean
  end
end
