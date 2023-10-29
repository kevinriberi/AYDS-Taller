# frozen_string_literal: true

require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Knowledge do
  before(:all) do
    @existing_user = User.create(username: 'Pablito10', email: 'pablito@example.com', password_digest: 'password')
    @existing_topic = Topic.create(name: 'Biologia', amount_questions_L1: 3, amount_questions_L2: 3, amount_questions_L3: 3)
  end

  after(:all) do
    @existing_topic.destroy
    @existing_user.destroy
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      user = @existing_user
      topic = @existing_topic
      knowledge = Knowledge.new(user: user, topic: topic, level: 1)
      expect(knowledge).to be_valid
    end

    it 'is not valid without a user' do
      topic = @existing_topic
      knowledge = Knowledge.new(topic: topic, level: 2)
      expect(knowledge).not_to be_valid
    end

    it 'is not valid without a topic' do
      user = @existing_user
      knowledge = Knowledge.new(user: user, level: 3)
      expect(knowledge).not_to be_valid
    end

    it 'is not valid with an invalid level' do
      user = @existing_user
      topic = @existing_topic
      knowledge = Knowledge.new(user: user, topic: topic, level: 6)
      expect(knowledge).not_to be_valid
    end
  end

  context 'methods' do
    it 'updates level and resets correct_answers_count after reaching the required correct answers' do
      user = @existing_user
      topic = @existing_topic
      knowledge = Knowledge.create(user: user, topic: topic, level: 1)

      knowledge.update_by_correct_answer # Update once
      expect(knowledge.level).to eq(1) # Level shouldn't change yet
      expect(knowledge.correct_answers_count).to eq(1)

      knowledge.update_by_correct_answer # Update twice
      expect(knowledge.level).to eq(1) # Level shouldn't change yet
      expect(knowledge.correct_answers_count).to eq(2)

      knowledge.update_by_correct_answer # Update thrice, should trigger level up
      expect(knowledge.level).to eq(2) # Level should increase to 2
      expect(knowledge.correct_answers_count).to eq(0)  # Correct answers count should reset

      knowledge.destroy
    end

    it 'calculates the correct percentage for a given level' do
      user = @existing_user
      topic = @existing_topic
      knowledge = Knowledge.create(user: user, topic: topic, correct_answers_count: 1, level: 2)
      expect(knowledge.percentage_of_correct_answers).to eq(33.3)

      knowledge.destroy
    end

    it 'returns true for is_finished when level is 4' do
      user = @existing_user
      topic = @existing_topic
      knowledge = Knowledge.create(user: user, topic: topic, level: 4)

      expect(knowledge.is_finished).to be_truthy

      knowledge.destroy
    end

    it 'returns false for is_finished when level is less than 4' do
      user = @existing_user
      topic = @existing_topic
      knowledge = Knowledge.create(user: user, topic: topic, level: 3)

      expect(knowledge.is_finished).to be_falsy

      knowledge.destroy
    end
  end
end
