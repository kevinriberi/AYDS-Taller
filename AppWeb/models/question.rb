class Question < ActiveRecord::Base
    belongs_to :topic
    has_many :options
    belongs_to :correct_option, class_name: "Option"
end