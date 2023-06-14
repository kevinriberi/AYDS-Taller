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
end