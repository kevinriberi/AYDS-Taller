class Question < ActiveRecord::Base
    belongs_to :topic
    has_many :options
    belongs_to :correct_option, class_name: "Option"

    validates :correct_option_id, presence: true
    validates :level, inclusion: { in: %w(Principiante Intermedio Avanzado), message: "%{value} no es un nivel permitido" }
end