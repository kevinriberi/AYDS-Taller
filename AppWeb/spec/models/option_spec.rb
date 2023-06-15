require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Option do
  # traigo una pregunta que ya sé que está en la DB de tests
  question = Question.find(1)

  it "is valid with a content and an existent question" do
  option = Option.new(content: "7", question_id: question.id)
  expect(option).to be_valid
  end

  it "is invalid without a content" do
    option = Option.new(question_id: question.id)
    expect(option).not_to be_valid
  end

  it "is invalid with an inexistent question" do
    option = Option.new(content: "7", question_id: 999)
    expect(option).not_to be_valid
  end
end