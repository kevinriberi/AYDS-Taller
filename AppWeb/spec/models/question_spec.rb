require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Question do
  topic = Topic.find_by(name: "Historia")

  it "is valid with a content, an existent topic and a level in {1,2,3}" do
    question = Question.new(content: "¿Cuándo fue la revolución de Mayo?", topic_id: topic.id, level: 1)
    expect(question).to be_valid
  end

  it "is invalid without a content" do
    question = Question.new(topic_id: topic.id, level: 1)
    expect(question).not_to be_valid
  end

it "is invalid without a existent topic" do
  question = Question.new(content: "¿Cuándo fue la 2da Guerra Mundial?", topic_id: 999, level: 1)
  expect(question).not_to be_valid
end

  it "is invalid with a negative level" do
    question = Question.new(content: "¿Cuándo fue la 3ra Guerra Mundial?", topic_id: topic.id, level: -2)
    expect(question).not_to be_valid
  end

  it "is invalid with a level greater than 3" do
    question = Question.new(content: "¿Cuándo fue la 4ta Guerra Mundial?", topic_id: topic.id, level: 4)
    expect(question).not_to be_valid
  end

  it "is invalid with a dupicate content" do
    question1 = Question.create(content: "¿Cuándo fue la 5ta Guerra Mundial?", topic_id: topic.id, level: 1)
    question2 = Question.new(content: "¿Cuándo fue la 5ta Guerra Mundial?", topic_id: topic.id, level: 2)
    expect(question2).not_to be_valid
  end
end