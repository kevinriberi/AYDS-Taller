class Option < ActiveRecord::Base
    
    belongs_to :question

    validates :content, :presence => true 
    validate :valid_question_id

    private
  
    def valid_question_id
        return if Question.exists?(question_id)
  
        errors.add(:question_id, "does not exist")
    end
end