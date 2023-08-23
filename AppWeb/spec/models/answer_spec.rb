require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Answer do
    # traigo elementos de la DB de test que se corresponden con las preguntas que queremos hacer
    user = User.find(1)
    topic = Topic.find(29)
    question_1 = Question.find(3)
    option_q1 = Option.find(1)

    # aca traigo una pregunta del tema "Deportes"
    question_2 = Question.find(4)
    option_q2 = Option.find(2)

    it "is valid with a valid user, an option of the question and a question of the user's level in the topic" do
        answer = Answer.new(user_id: user.id, question_id: question_1.id, option_id: option_q1.id)
        expect(answer).to be_valid
    end

    it "is invalid without an user" do
        answer = Answer.new(question_id: question_1.id, option_id: option_q1.id)
        expect(answer).not_to be_valid
    end

    it "is invalid without a question" do
        answer = Answer.new(user_id: user.id, option_id: option_q1.id)
        expect(answer).not_to be_valid
    end

    it "is invalid without an option" do
        answer = Answer.new(user_id: user.id, question_id: question_1.id)
        expect(answer).not_to be_valid
    end

    it "is invalid with an option of other question" do
        answer = Answer.new(user_id: user.id, question_id: question_1.id, option_id: option_q2.id)
        expect(answer).not_to be_valid
    end

    it "is invalid with an question of diferent user's level in the topic" do
        answer = Answer.new(user_id: user.id, question_id: question_2.id, option_id: option_q2.id)
        expect(answer).not_to be_valid
    end
end