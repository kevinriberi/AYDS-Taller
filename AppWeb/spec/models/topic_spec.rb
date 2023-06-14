require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Topic do
  it "is valid with a name and amount of questions greater or equal than zero" do
    topic = Topic.new(name: "Historia", amount_questions_L1: 0, amount_questions_L2: 2, amount_questions_L3: 1)
    expect(topic).to be_valid
  end

  it "is invalid without a name" do
    topic = Topic.new(amount_questions_L1: 0, amount_questions_L2: 0, amount_questions_L3: 0)
    expect(topic).not_to be_valid
  end

  it "is invalid without an amount of questions of level 1" do
    topic = Topic.new(name: "Matematica", amount_questions_L2: 0, amount_questions_L3: 1)
    expect(topic).not_to be_valid
  end

  it "is invalid without an amount of questions of level 2" do
    topic = Topic.new(name: "Matematica", amount_questions_L1: 1, amount_questions_L3: 0)
    expect(topic).not_to be_valid
  end

  it "is invalid without an amount of questions of level 3" do
    topic = Topic.new(name: "Matematica", amount_questions_L1: 0, amount_questions_L3: 1)
    expect(topic).not_to be_valid
  end

  it "is invalid with an amount of questions of level 1 negative" do
    topic = Topic.new(name: "Matematica", amount_questions_L1: -1, amount_questions_L2: 1, amount_questions_L3: 0)
    expect(topic).not_to be_valid
  end

  it "is invalid with an amount of questions of level 2 negative" do
    topic = Topic.new(name: "Matematica", amount_questions_L1: 1, amount_questions_L2: -1, amount_questions_L3: 0)
    expect(topic).not_to be_valid
  end

  it "is invalid with an amount of questions of level 2 negative" do
    topic = Topic.new(name: "Matematica", amount_questions_L1: 1, amount_questions_L2: 1, amount_questions_L3: -5)
    expect(topic).not_to be_valid
  end
end