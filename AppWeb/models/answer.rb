class Answer < ActiveRecord::Base
    
    belongs_to :user
    belongs_to :question
    belongs_to :option

    
    validates :user_id, presence: true
    validates :question_id, presence: true
    validates :option_id, presence: true

    validate :valid_user_id
    validate :valid_question_id
    validate :valid_option_id

    validate :valid_option_respect_question
    validate :matching_user_level_in_topic

    private

    def valid_user_id
        return if User.exists?(user_id)

        errors.add(:user_id, "does not exist")
    end

    def valid_question_id
        return if Question.exists?(question_id)

        errors.add(:question_id, "does not exist")
    end

    def valid_option_id
        return if Option.exists?(option_id)

        errors.add(:option_id, "does not exist")
    end

    def valid_option_respect_question
        if option.present? && option.question_id != question_id
            errors.add(:option_id, "does not belong to the corresponding question")
        end
    end
    
    def matching_user_level_in_topic
        if question.present?
            topic = question.topic_id
            knowledge = Knowledge.find_by(user_id: user_id, topic_id: topic)
    
            if knowledge.nil? || question.level != knowledge.level
                errors.add(:question, "must have the same level as the user's level in the topic")
            end
        end
    end
end