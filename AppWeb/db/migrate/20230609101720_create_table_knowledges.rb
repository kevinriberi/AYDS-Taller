class CreateTableKnowledges < ActiveRecord::Migration[7.0]
  def change
    create_table :knowledges do |t|
      t.references :user, foreign_key: true
      t.references :topic, foreign_key: true

      t.integer :level
      t.integer :correct_answers_count

      t.timestamps
    end
  end
end