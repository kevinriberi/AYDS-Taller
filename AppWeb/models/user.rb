class User < ActiveRecord::Base
    has_secure_password

    has_many :answers
    has_many :knowledges
    has_many :topics, :through => :knowledges

    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    def update_points (correct, level, time)
        points = 10 * level + self.streak + time 
        
        if !correct 
            if points > self.points
                points = self.points * -1
            else
                points *= -1
            end
        end

        self.points += points
        #if correct
        #    self.points += points
        #else
        #    points_before_rest = self.points
        #    self.points -= points
        #    if self.points < 0
        #        self.points = 0
        #        points = points_before_rest * -1
        #    else
        #        points *= -1
        #    end
        #end

        return points
    end

    def update_streak (correct)
        if correct
            self.streak = [self.streak + 1, 1].max
          else
            self.streak = [self.streak - 1, -1].min
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