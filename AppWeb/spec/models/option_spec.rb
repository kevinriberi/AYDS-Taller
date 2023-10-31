# frozen_string_literal: true

require 'sinatra/activerecord'
require_relative '../../models/init.rb'

describe Option do
  before(:all) do
    @existing_topic = Topic.create(:name => 'Deportes', :amount_questions_L1 => 5, :amount_questions_L2 => 5, :amount_questions_L3 => 3)
    @existing_question = Question.create(:content => '¿Cuántos jugadores tiene un equipo de basquet?', :topic => @existing_topic, :level => 2)
  end

  after(:all) do
    @existing_question.destroy
    @existing_topic.destroy
  end

  it 'is valid with a content and an existent question' do
    topic = @existing_topic
    question = @existing_question

    option = Option.new(:content => '7', :question => question)
    expect(option).to be_valid
  end

  it 'is invalid without a content' do
    question = @existing_question
    option = Option.new(:question => question)
    expect(option).not_to be_valid
  end

  it 'is invalid with an inexistent question' do
    topic = @existing_topic
    question_for_destroy = question = Question.create(:content => '¿Cuántos jugadores tiene un equipo de rugby?', :topic => topic, :level => 2)
    id_before_destroy = question_for_destroy.id
    question_for_destroy.destroy
    option = Option.new(:content => '7', :question_id => id_before_destroy)
    expect(option).not_to be_valid
  end
end
