class Question < ActiveRecord::Base
    
    belongs_to :topic
    has_many :answers
    has_many :options

    validates :content, :presence => true, :uniqueness => true
    validates :level, :presence => true, :inclusion => { :in => 1..3 }
    validate :valid_topic_id

    private
  
    def valid_topic_id
        return if Topic.exists?(topic_id)
  
        errors.add(:topic_id, "does not exist")
    end
end