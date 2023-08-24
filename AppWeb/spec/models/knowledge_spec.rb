require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Knowledge do
  context "validations" do
    it "is valid with valid attributes" do
      user = User.create(username: "John", email: "john@example.com", password: "password")
      topic = Topic.create(name: "Math")
      knowledge = Knowledge.new(user: user, topic: topic, level: 1)
      expect(knowledge).to be_valid
    end

    it "is not valid without a user" do
      topic = Topic.create(name: "Science")
      knowledge = Knowledge.new(topic: topic, level: 2)
      expect(knowledge).not_to be_valid
    end

    it "is not valid without a topic" do
      user = User.create(username: "Alice", email: "alice@example.com", password: "password")
      knowledge = Knowledge.new(user: user, level: 3)
      expect(knowledge).not_to be_valid
    end

    it "is not valid with an invalid level" do
      user = User.create(username: "Bob", email: "bob@example.com", password: "password")
      topic = Topic.create(name: "History")
      knowledge = Knowledge.new(user: user, topic: topic, level: 5)
      expect(knowledge).not_to be_valid
    end
  end

  context "methods" do
    it "updates level and resets correct_answers_count after reaching the required correct answers" do
      user = User.create(username: "Eve", email: "eve@example.com", password: "password")
      topic = Topic.create(name: "English", amount_questions_L1: 3)  # Set the required questions for level 1
      knowledge = Knowledge.create(user: user, topic: topic, level: 1)
      
      knowledge.update_by_correct_answer  # Update once
      expect(knowledge.level).to eq(1)  # Level shouldn't change yet
      expect(knowledge.correct_answers_count).to eq(1)
      
      knowledge.update_by_correct_answer  # Update twice
      expect(knowledge.level).to eq(1)  # Level shouldn't change yet
      expect(knowledge.correct_answers_count).to eq(2)
      
      knowledge.update_by_correct_answer  # Update thrice, should trigger level up
      expect(knowledge.level).to eq(2)  # Level should increase to 2
      expect(knowledge.correct_answers_count).to eq(0)  # Correct answers count should reset
    end

    it "returns true for is_finished when level is 4" do
      user = User.create(username: "Frank", email: "frank@example.com", password: "password")
      topic = Topic.create(name: "Art")
      knowledge = Knowledge.create(user: user, topic: topic, level: 4)
      
      expect(knowledge.is_finished).to be_truthy
    end

    it "returns false for is_finished when level is less than 4" do
      user = User.create(username: "Grace", email: "grace@example.com", password: "password")
      topic = Topic.create(name: "Music")
      knowledge = Knowledge.create(user: user, topic: topic, level: 3)
      
      expect(knowledge.is_finished).to be_falsy
    end
  end
end
