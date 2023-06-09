class Topic < ActiveRecord::Base
    has_many :questions

    has_many :knowledges
    has_many :users, :through => :knowledges
end