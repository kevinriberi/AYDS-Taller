class AddCorrectOptionToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :correct_option_id, :integer
  end
end
