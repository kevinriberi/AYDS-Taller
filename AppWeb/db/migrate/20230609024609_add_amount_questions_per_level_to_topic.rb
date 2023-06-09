class AddAmountQuestionsPerLevelToTopic < ActiveRecord::Migration[7.0]
  def change
    add_column :topics, :amount_questions_L1, :integer
    add_column :topics, :amount_questions_L2, :integer
    add_column :topics, :amount_questions_L3, :integer
  end
end
