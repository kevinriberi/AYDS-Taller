class Knowledge < ActiveRecord::Base
    belongs_to :user
    belongs_to :topic

    validates :user_id, presence: true
    validates :topic_id, presence: true
  
    validate :valid_user_id
    validate :valid_topic_id
  
    private
  
    def valid_user_id
      return if User.exists?(user_id)
  
      errors.add(:user_id, "does not exist")
    end
  
    def valid_topic_id
      return if Topic.exists?(topic_id)
  
      errors.add(:topic_id, "does not exist")
    end
end