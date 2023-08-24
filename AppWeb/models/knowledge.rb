class Knowledge < ActiveRecord::Base
    belongs_to :user
    belongs_to :topic

    validates :user_id, presence: true
    validates :topic_id, presence: true
    validates :level, presence: true, inclusion: { in: 1..4 }
  
    validate :valid_user_id
    validate :valid_topic_id
  
    # metodo que actualiza la relacion knowledge, devuelve true si se aumenta de nivel
    #def update_by_correct_answer
    #  self.correct_answers_count += 1
    #  if (self.correct_answers_count == 3)
    #    self.level += 1
    #    self.correct_answers_count = 0
    #    true
    #  else
    #    false
    #  end
    #end
     
    def update_by_correct_answer
      self.correct_answers_count ||= 0
      level_up_threshold = topic.send("amount_questions_L#{level}".to_sym)
  
      self.correct_answers_count += 1
      if self.correct_answers_count >= level_up_threshold
        self.level += 1
        self.correct_answers_count = 0
        true
      else
        false
      end
    end
  





    # metodo que corrobora si se ha completado el tema en su totalidad
    def is_finished
      if self.level == 4
        true
      else
        false
      end
    end

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