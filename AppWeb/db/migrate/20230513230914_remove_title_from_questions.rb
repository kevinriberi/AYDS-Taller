class RemoveTitleFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :title
  end
end
