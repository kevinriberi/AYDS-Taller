# frozen_string_literal: true

require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Answer do
  before(:all) do
    @existing_user = User.create(username: 'Pablito10', email: 'pablito@example.com', password_digest: 'password')
    @existing_user_2 = User.create(username: 'Mateo19', email: 'mateo19@example.com', password_digest: 'password')
    @existing_topic = Topic.create(name: 'Geografía', amount_questions_L1: 3, amount_questions_L2: 3, amount_questions_L3: 3)
    @existing_question_1 = Question.create(content: '¿Cuál es la capital de Armenia?', topic: @existing_topic, level: 3)
    @existing_question_2 = Question.create(content: '¿Cuál es la población de China?', topic: @existing_topic, level: 2)
    @existing_option_q1 = Option.create(content: 'Nueva Dehli', question: @existing_question_1)
    @existing_option_q2 = Option.create(content: 'Mil millones de habitantes', question: @existing_question_2)
    Knowledge.create(user: @existing_user, topic: @existing_topic, level: 3)
    Knowledge.create(user: @existing_user_2, topic: @existing_topic, level: 1)
  end

  after(:all) do
    Knowledge.destroy_all
    @existing_option_q1.destroy
    @existing_option_q2.destroy
    @existing_question_1.destroy
    @existing_question_2.destroy
    @existing_topic.destroy
    @existing_user.destroy
    @existing_user_2.destroy
  end

  it "is valid with a valid user, an option of the question and a question of the user's level in the topic" do
    user = @existing_user
    topic = @existing_topic
    question = @existing_question_1
    option = @existing_option_q1
    answer = Answer.new(user: user, question: question, option: option)
    expect(answer).to be_valid
  end

  it 'is invalid without an user' do
    question = @existing_question_1
    option = @existing_option_q1
    answer = Answer.new(question: question, option: option)
    expect(answer).not_to be_valid
  end

  it 'is invalid without a question' do
    user = @existing_user
    option = @existing_option_q1
    answer = Answer.new(user: user, option: option)
    expect(answer).not_to be_valid
  end

  it 'is invalid without an option' do
    user = @existing_user
    question = @existing_question_1
    answer = Answer.new(user: user, question: question)
    expect(answer).not_to be_valid
  end

  it 'is invalid with an option of other question' do
    user = @existing_user
    question = @existing_question_1
    option_q2 = @existing_option_2
    answer = Answer.new(user: user, question: question, option: option_q2)
    expect(answer).not_to be_valid
  end

  it "is invalid with an question of diferent user's level in the topic" do
    user_2 = @existing_user_2
    question_1 = @existing_question_1
    option_q1 = @existing_option_q1
    answer = Answer.new(user: user_2, question: question_1, option: option_q1)
    expect(answer).not_to be_valid
  end
end
