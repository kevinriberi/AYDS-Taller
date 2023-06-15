class Topic < ActiveRecord::Base
    has_many :questions

    has_many :knowledges
    has_many :users, :through => :knowledges

    validates :name, presence: true, uniqueness: true
    validates :amount_questions_L1, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :amount_questions_L2, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :amount_questions_L3, presence: true, numericality: { greater_than_or_equal_to: 0 }

    validate :validate_questions_amount

    private

    def validate_questions_amount
        if amount_questions_L1.to_i < 0 || amount_questions_L2.to_i < 0 || amount_questions_L3.to_i < 0
         errors.add(:base, "Amount of questions should be greater than or equal to 0 for all levels")
        end
    end
end