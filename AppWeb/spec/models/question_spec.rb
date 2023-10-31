# frozen_string_literal: true

require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Question do
  before(:all) do
    @existing_topic = Topic.create(:name => 'Historia', :amount_questions_L1 => 3, :amount_questions_L2 => 3, :amount_questions_L3 => 3)
  end

  after(:all) do
    @existing_topic.destroy
  end

  it 'is valid with a content, an existent topic and a level in {1,2,3}' do
    topic = @existing_topic
    question = Question.new(:content => '¿Cuándo fue la revolución de Mayo?', :topic => topic, :level => 1)
    expect(question).to be_valid
  end

  it 'is invalid without a content' do
    topic = @existing_topic
    question = Question.new(:topic => topic, :level => 1)
    expect(question).not_to be_valid
  end

  it 'is invalid without a existent topic' do
    topic_for_destroy = Topic.create(:name => 'Ciencias Naturales', :amount_questions_L1 => 3, :amount_questions_L2 => 3, :amount_questions_L3 => 3)
    id_before_destroy = topic_for_destroy.id
    topic_for_destroy.destroy
    question = Question.new(:content => '¿Cuándo fue la 2da Guerra Mundial?', :topic_id => id_before_destroy, :level => 1)
    expect(question).not_to be_valid
  end

  it 'is invalid with a negative level' do
    topic = @existing_topic
    question = Question.new(:content => '¿Cuándo fue la 3ra Guerra Mundial?', :topic => topic, :level => -2)
    expect(question).not_to be_valid
  end

  it 'is invalid with a level greater than 3' do
    topic = @existing_topic
    question = Question.new(:content => '¿Cuándo fue la 4ta Guerra Mundial?', :topic => topic, :level => 4)
    expect(question).not_to be_valid
  end

  it 'is invalid with a dupicate content' do
    topic = @existing_topic
    question1 = Question.create(:content => '¿Cuándo fue la 5ta Guerra Mundial?', :topic => topic, :level => 1)
    question2 = Question.new(:content => '¿Cuándo fue la 5ta Guerra Mundial?', :topic => topic, :level => 2)
    expect(question2).not_to be_valid
    question1.destroy
  end
end
