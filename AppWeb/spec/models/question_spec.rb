require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Question do
  it "is valid with a content, an existent topic and a level in {1,2,3}" do
    topic = Topic.create(name: "Historia", amount_questions_L1: 1, amount_questions_L2: 1, amount_questions_L3: 1)
    question = Question.new(content: "¿Cuándo fue la 1ra Guerra Mundial?", topic_id: topic.id, level: 1)
    expect(question).to be_valid
  end

  it "is invalid without a content" do
    topic = Topic.create(name: "Historia", amount_questions_L1: 1, amount_questions_L2: 1, amount_questions_L3: 1)
    question = Question.new(topic_id: topic.id, level: 1)
    expect(question).not_to be_valid
  end

  it "is invalid without a existent topic" do
    topic = Topic.create(name: "Historia", amount_questions_L1: 1, amount_questions_L2: 1, amount_questions_L3: 1)
    topic_id = topic.id
    topic.destroy
    question = Question.new(content: "¿Cuándo fue la 1ra Guerra Mundial?", topic_id: topic_id, level: 1)
    expect(question).not_to be_valid
  end

  it "is invalid with a negative level" do
    topic = Topic.create(name: "Historia", amount_questions_L1: 1, amount_questions_L2: 1, amount_questions_L3: 1)
    topic_id = topic.id
    question = Question.new(content: "¿Cuándo fue la 1ra Guerra Mundial?", topic_id: topic_id, level: -2)
    expect(question).not_to be_valid
  end

  it "is invalid with a level greater than 3" do
    topic = Topic.create(name: "Historia", amount_questions_L1: 1, amount_questions_L2: 1, amount_questions_L3: 1)
    topic_id = topic.id
    question = Question.new(content: "¿Cuándo fue la 1ra Guerra Mundial?", topic_id: topic_id, level: 4)
    expect(question).not_to be_valid
  end

end