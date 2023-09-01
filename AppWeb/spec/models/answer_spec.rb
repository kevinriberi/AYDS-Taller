require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Answer do
    user = User.create(username: "Pablito10", email: "pablito@example.com", password_digest: "password")
    topic_1 = Topic.create(name: "Geografía", amount_questions_L1: 3, amount_questions_L2: 3, amount_questions_L3: 3)
    question_1 = Question.create(content: "¿Cuál es la capital de la Argentina?", topic: topic_1, level: 3)
    option_q1 = Option.create(content: "Nueva Dehli", question: question_1)
    Knowledge.create(user: user, topic: topic_1, level: 3)

    topic_2 = Topic.create(name: "Música", amount_questions_L1: 3, amount_questions_L2: 3, amount_questions_L3: 3)
    question_2 = Question.create(content: "¿A qué familia pertenece la pandereta?", topic: topic_2, level: 2)
    option_q2 = Option.create(content: "Instrumentos de percusión", question: question_2)
    Knowledge.create(user: user, topic: topic_2, level: 1)

    it "is valid with a valid user, an option of the question and a question of the user's level in the topic" do

        user3 = User.create(username: "Mateo19", email: "mateo19@example.com", password_digest: "password")
        topic_3 = Topic.create(name: "Gastronomía", amount_questions_L1: 3, amount_questions_L2: 3, amount_questions_L3: 3)
        question_3 = Question.create(content: "¿De qué país es originario el Onigiri", topic: topic_3, level: 3)
        option_q3 = Option.create(content: "Japón", question: question_3)
        knowledge_3 = Knowledge.create(user: user3, topic: topic_3, level: 3)
        answer = Answer.new(user: user3, question: question_3, option: option_q3)
        expect(answer).to be_valid
        knowledge_3.destroy
        option_q3.destroy
        question_3.destroy
        topic_3.destroy
        user3.destroy

    end

    it "is invalid without an user" do
        answer = Answer.new(question: question_1, option: option_q1)
        expect(answer).not_to be_valid
    end

    it "is invalid without a question" do
        answer = Answer.new(user: user, option: option_q1)
        expect(answer).not_to be_valid
    end

    it "is invalid without an option" do
        answer = Answer.new(user: user, question: question_1)
        expect(answer).not_to be_valid
    end

    it "is invalid with an option of other question" do
        answer = Answer.new(user: user, question: question_1, option: option_q2)
        expect(answer).not_to be_valid
    end

    it "is invalid with an question of diferent user's level in the topic" do
        answer = Answer.new(user: user, question: question_2, option: option_q2)
        expect(answer).not_to be_valid
    end


    Knowledge.destroy_all
    option_q1.destroy
    option_q2.destroy
    question_1.destroy
    question_2.destroy
    topic_1.destroy
    topic_2.destroy
    user.destroy

end