# spec/controllers/access_controller_spec.rb
require 'rack/test'
require_relative '../../server.rb'

RSpec.describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    # incluir el nombre de la clase correspondiente a la Application definida en el server.rb
    App
  end

  context 'POST /login' do
    before(:all) do
      @existing_user = User.create(:username => 'test_user', :email => 'test@example.com', :password => 'password123')
    end

    after(:all) do
      @existing_user.destroy
    end

    it 'debería autenticar al usuario y redirigirlo al inicio si las credenciales son válidas' do
      post '/login', { :username => 'test_user', :email => 'test@example.com', :password => 'password123' }

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/')
    end

    it 'debería mostrar un mensaje de error cuando la contraseña es incorrecta' do
      user = @existing_user
      wrong_password = user.password + 'jfidsoajdisa'

      post '/login', { :username => user.username, :email => user.email, :password => wrong_password }

      expect(last_response).to be_ok
      expect(last_response.body).to include('Usuario o contraseña incorrecta')
    end
  end

  context 'POST /register' do
    before(:all) do
      @existing_user = User.create(:username => 'test_user', :email => 'test@example.com', :password => 'password123')
    end

    after(:all) do
      @existing_user.destroy
    end

    it 'debería registrar un nuevo usuario y redirigirlo a la página de inicio de sesión' do
      post '/register', { :username => 'nuevo_usuario', :email => 'nuevo@example.com', :password => 'password123', :confirm_password => 'password123' }

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/login')
      expect(last_response.body).to include('¡Te has registrado con éxito! ¡Inicia sesión para comenzar a jugar!')

      # Se chequea que el nuevo usuario exista en la base de datos y luego se elimina
      new_user = User.find_by(:username => 'nuevo_usuario')
      expect(new_user).not_to be_nil

      new_user.destroy
    end

    it 'debería mostrar un mensaje de error si el nombre de usuario ya está tomado' do
      user = @existing_user

      post '/register', { :username => user.username, :email => 'nuevoemail@example.com', :password => 'password123', :confirm_password => 'password123' }

      expect(last_response.body).to include('El nombre de usuario ya está registrado')
    end

    it 'debería mostrar un mensaje de error si el email usuario ya está tomado' do
      user = @existing_user

      post '/register', { :username => 'nuevo_usuario', :email => user.email, :password => 'password123', :confirm_password => 'password123' }

      expect(last_response.body).to include('La dirección de email ya está registrada con otro usuario')
    end

    it 'debería mostrar un mensaje de error si las contraseñas no coinciden' do
      post '/register', { :username => 'nuevo_usuario', :email => 'nuevo@example.com', :password => 'password123', :confirm_password => 'otraPassword' }

      expect(last_response.body).to include('Las contraseñas no coinciden o estan vacias')
    end
  end
end