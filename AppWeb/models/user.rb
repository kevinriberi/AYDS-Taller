class User < ActiveRecord::Base
    has_secure_password

    has_many :answers
    has_many :knowledges
    has_many :topics, :through => :knowledges

    validates :username, presence: true
    validates :email, presence: true, uniqueness: true

    def update_points (correct, level)
        if correct
            self.points += 10 * level
        else
            self.points -= 4 * level
        end
    end
end