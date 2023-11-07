# spec/controllers/statistics_controller_spec.rb
require 'rack/test'
require_relative '../../server.rb'

RSpec.describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    # incluir el nombre de la clase correspondiente a la Application definida en el server.rb
    App
  end

  context 'GET /history/:time_frame' do
    before(:all) do
      @existing_user = User.create(:username => 'test_user10', :email => 'testttttt@example.com', :password => 'password123')
    end

    after(:all) do
      @existing_user.destroy
    end

    it 'returns a 200 OK status with a period of a week' do
      user = @existing_user
      session = { :user_id => user.id }

      get '/history/week', {}, 'rack.session' => session

      expect(last_response).to be_ok
    end

    it 'returns a 200 OK status with a period of a month' do
      user = @existing_user
      session = { :user_id => user.id }

      get '/history/month', {}, 'rack.session' => session

      expect(last_response).to be_ok
    end

    it 'returns a 200 OK status with a period of 3 months' do
      user = @existing_user
      session = { :user_id => user.id }

      get '/history/3month', {}, 'rack.session' => session

      expect(last_response).to be_ok
    end
  end
end
