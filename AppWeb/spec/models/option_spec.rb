require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Option do
  topic = Topic.create(name: "Deportes", amount_questions_L1: 5, amount_questions_L2: 5, amount_questions_L3: 3)
  question = Question.create(content: "¿Cuántos jugadores tiene un equipo de basquet?", topic: topic, level: 2)

  it "is valid with a content and an existent question" do
  option = Option.new(content: "7", question: question)
  expect(option).to be_valid
  end

  it "is invalid without a content" do
    option = Option.new(question: question)
    expect(option).not_to be_valid
  end

  it "is invalid with an inexistent question" do
    question_for_destroy = question = Question.create(content: "¿Cuántos jugadores tiene un equipo de rugby?", topic: topic, level: 2)
    id_before_destroy = question_for_destroy.id
    question_for_destroy.destroy
    option = Option.new(content: "7", question_id: id_before_destroy)
    expect(option).not_to be_valid
  end

  question.destroy
  topic.destroy
end