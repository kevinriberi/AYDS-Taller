class User < ActiveRecord::Base
    has_secure_password

    has_many :answers
    has_many :knowledges
    has_many :topics, :through => :knowledges

    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    def update_points (correct, level)
        if correct
            self.points += 10 * level
        else
            self.points -= 4 * level
        end
    end

    def initialize_knowledges
        topics = Topic.all

        topics.each do |topic|
            Knowledge.create(user_id: self.id, topic_id: topic.id, level: 1, correct_answers_count: 0)
        end
        self.points = 0
    end

    def self.username_taken?(username)
        User.exists?(username: username)
    end
      
    def self.email_taken?(email)
        User.exists?(email: email)
    end
      
    def self.passwords_match?(password, confirm_password)
        !password.empty? && !confirm_password.empty? && password == confirm_password
    end
      
end