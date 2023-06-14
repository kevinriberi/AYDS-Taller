require 'sinatra/activerecord'
require_relative '../../models/init.rb'

RSpec.describe Option do
  it "is valid with a content and an existent question" do
  topic = Topic.create(name: "Juegos de mesa", amount_questions_L1: 1, amount_questions_L2: 1, amount_questions_L3: 1)
  question = Question.create(content: "¿Cuántos jugadores tiene un equipo de basquet?", topic_id: topic.id, level: 1)
  option = Option.new(content: "7", question_id: question.id)
  expect(option).to be_valid
  end

  it "is invalid without a content" do
    topic = Topic.create(name: "Juegos de mesa", amount_questions_L1: 1, amount_questions_L2: 1, amount_questions_L3: 1)
    question = Question.create(content: "¿Cuántos jugadores tiene un equipo de basquet?", topic_id: topic.id, level: 1)
    option = Option.new(question_id: question.id)
    expect(option).not_to be_valid
  end

  it "is invalid with an inexistent question" do
    topic = Topic.create(name: "Juegos de mesa", amount_questions_L1: 1, amount_questions_L2: 1, amount_questions_L3: 1)
    question = Question.create(content: "¿Cuántos jugadores tiene un equipo de basquet?", topic_id: topic.id, level: 1)
    question_id = question.id
    question.destroy
    option = Option.new(content: "7", question_id: question_id)
    expect(option).not_to be_valid
  end
end