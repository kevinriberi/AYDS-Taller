# frozen_string_literal: true

# spec/app_spec.rb
require 'rack/test'
require_relative '../server.rb'

RSpec.describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    # incluir el nombre de la clase correspondiente a la Application definida en el server.rb
    App
  end

  context 'probando rutas del server' do
    before(:all) do
      @existing_user = User.create(:username => 'test_user10', :email => 'testttttt@example.com', :password => 'password123')
    end

    after(:all) do
      @existing_user.destroy
    end

    it 'se accede a la ruta principal' do
      get '/'
      expect(last_response.status).to eq(200)
    end

    it 'se accede a la ruta de login' do
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it 'se accede a la ruta de registro' do
      get '/register'
      expect(last_response.status).to eq(200)
    end

    it 'se accede a la ruta de ranking' do
      get '/ranking'
      expect(last_response.status).to eq(200)
    end

    it 'se accede a la ruta del ranking desde el dashboard' do
      user = @existing_user
      session = { :user_id => user.id, :from_dashboard => true }

      get '/ranking', {}, 'rack.session' => session

      expect(last_response).to be_ok
    end
  end

  context 'se chequea si se recibe la vista correcta en la ruta /' do
    before(:all) do
      @existing_user = User.create(:username => 'test_user10', :email => 'testexample.com', :password => 'password123')
    end

    after(:all) do
      @existing_user.destroy
    end

    it 'debería renderizar la vista de dashboard si el usuario está autenticado' do
      user = @existing_user
      session = { :user_id => user.id }

      get '/', {}, 'rack.session' => session

      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('<h1>¡Hola, test_user10!</h1>')
    end

    it 'debería renderizar la vista de índice si el usuario no está autenticado' do
      session = {}
      get '/', {}, 'rack.session' => session

      expect(last_response.status).to eq(200)

      expect(last_response.body).to include('<h1>Bienvenido a Prelude-Code!</h1>')
    end
  end
end







