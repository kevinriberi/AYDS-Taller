class CreateUserTopicInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :user_topic_infos do |t|
      t.references :user, :null => false, :foreign_key => true
      t.references :topic, :null => false, :foreign_key => true
      t.string :level
      t.integer :correct_answers_count
    
      t.timestamps
    end
  end
end

