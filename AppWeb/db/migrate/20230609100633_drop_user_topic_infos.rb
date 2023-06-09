class DropUserTopicInfos < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_topic_infos
  end
end
