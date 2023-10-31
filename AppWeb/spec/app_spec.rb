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

  context 'probando la ruta /topics/:id' do
    before(:all) do
      @existing_user = User.create(:username => 'test_user10', :email => 'testttttt@example.com', :password => 'password123')
      @existing_topic = Topic.create(:name => 'Historia', :amount_questions_L1 => 3, :amount_questions_L2 => 3, :amount_questions_L3 => 3)
      @existing_question = Question.create(:content => '¿Cuál es la capital de Francia?', :topic => @existing_topic, :level => 1)
      Knowledge.create(:user => @existing_user, :topic => @existing_topic, :level => 1)
    end

    after(:all) do
      Knowledge.destroy_all
      @existing_user.destroy
      @existing_question.destroy
      @existing_topic.destroy
    end

    it 'debería redirigir a una pregunta si el topic_id es válido' do
      user = @existing_user
      topic = @existing_topic
      topic_id = topic.id

      session = { :user_id => user.id }
      # Llama a la ruta con el topic_id valido y la sesion
      get "/topics/#{topic_id}", {}, 'rack.session' => session

      expect(last_response.redirect?).to be true
      expect(last_response.status).to eq(302)
    end

    it 'debería devolver un error 404 si el topic_id no es válido' do
      user = @existing_user
      topic = Topic.create(:name => 'Test Topic and Destroy', :amount_questions_L1 => 2, :amount_questions_L2 => 2, :amount_questions_L3 => 2)
      topic_id = topic.id
      topic.destroy

      session = { :user_id => user.id }

      # Llama a la ruta con el topic_id invalido y la sesion
      get "/topics/#{topic_id}", {}, 'rack.session' => session

      expect(last_response.status).to eq(404)
      expect(last_response.body).to include('Not Found')
    end
  end

  context 'pruebas para /questions/:id/answer' do
    before(:all) do
      @existing_topic = Topic.create(:name => 'Historia', :amount_questions_L1 => 3, :amount_questions_L2 => 3, :amount_questions_L3 => 3)
      @existing_question = Question.create(:content => '¿Cuál es la capital de Francia?', :topic => @existing_topic, :level => 1)
    end

    after(:all) do
      @existing_question.destroy
      @existing_topic.destroy
    end

    it 'debería mostrar la pregunta si el ID de la pregunta es válido' do
      question = @existing_question
      question_id = question.id

      get "/questions/#{question_id}/answer"

      expect(last_response.status).to eq(200)
    end

    it 'debería devolver un error 404 si el ID de la pregunta no es válido' do
      topic = @existing_topic
      # Crea una pregunta valida en tu base de datos y obten su ID
      question = Question.create(:content => '¿Cuál es la capital de Lituania?', :topic => topic, :level => 1)
      invalid_question_id = question.id

      question.destroy

      get "/questions/#{invalid_question_id}/answer"

      expect(last_response.status).to eq(404)
      expect(last_response.body).to include('Not Found')
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

  context 'POST /answers' do
    before(:all) do
      @existing_user = User.create(:username => 'test_user', :email => 'test@example.com', :password => 'password123')
      @existing_topic = Topic.create(:name => 'Test Topic', :amount_questions_L1 => 3, :amount_questions_L2 => 3, :amount_questions_L3 => 3)
      @existing_question = Question.create(:content => '¿Cuál es la capital de Francia?', :topic => @existing_topic, :level => 1)
      @existing_question_level3 = Question.create(:content => '¿Cuál es la capital de Cordoba?', :topic => @existing_topic, :level => 3)
      @existing_option = Option.create(:content => 'París', :correct => true, :question => @existing_question)
      @existing__incorrect_option = Option.create(:content => 'Tolouse', :correct => false, :question => @existing_question)
      @existing_option_level3 = Option.create(:content => 'Cordoba', :correct => true, :question => @existing_question_level3)
    end

    after(:all) do
      @existing_user.destroy
      @existing_option.destroy
      @existing__incorrect_option.destroy
      @existing_option_level3.destroy
      @existing_question.destroy
      @existing_question_level3.destroy
      @existing_topic.destroy
    end

    it 'se responde una pregunta bien y no se sube de nivel' do
      user = @existing_user
      topic = @existing_topic
      question = @existing_question
      option = @existing_option
      knowledge = Knowledge.create(:user => user, :topic => topic, :correct_answers_count => 0, :level => 1)

      session = { :user_id => user.id }

      post '/answers', { :question_id => question.id, :option_id => option.id, :time => 10 }, 'rack.session' => session

      expect(last_response.redirect?).to be true

      knowledge.destroy
      Answer.destroy_all
    end

    it 'se responde una pregunta bien y se sube de nivel' do
      user = @existing_user
      topic = @existing_topic
      question = @existing_question
      option = @existing_option
      knowledge = Knowledge.create(:user => user, :topic => topic, :correct_answers_count => 2, :level => 1)

      session = { :user_id => user.id }

      post '/answers', { :question_id => question.id, :option_id => option.id, :time => 10 }, 'rack.session' => session

      expect(last_response.redirect?).to be true

      knowledge.destroy
      Answer.destroy_all
    end

    it 'se responde una pregunta bien y se completa el tema' do
      user = @existing_user
      topic = @existing_topic
      question = @existing_question_level3
      option = @existing_option_level3

      knowledge = Knowledge.create(:user => user, :topic => topic, :correct_answers_count => 2, :level => 3)

      session = { :user_id => user.id }

      post '/answers', { :question_id => question.id, :option_id => option.id, :time => 10 }, 'rack.session' => session

      expect(last_response.redirect?).to be true

      Answer.destroy_all
      knowledge.destroy
    end

    it 'se responde una pregunta mal' do
      user = @existing_user
      topic = @existing_topic
      question = @existing_question
      option = @existing__incorrect_option
      knowledge = Knowledge.create(:user => user, :topic => topic, :correct_answers_count => 0, :level => 1)

      session = { :user_id => user.id }

      post '/answers', { :question_id => question.id, :option_id => option.id, :time => 10 }, 'rack.session' => session

      expect(last_response.redirect?).to be true

      Answer.destroy_all
      knowledge.destroy
    end
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

  context 'GET /answers/:date' do
    before(:all) do
      @existing_user = User.create(:username => 'test_user10', :email => 'testttttt@example.com', :password => 'password123')
    end

    after(:all) do
      @existing_user.destroy
    end

    it 'returns a 200 OK status' do
      user = @existing_user
      session = { :user_id => user.id }

      date = Date.today.strftime('%Y-%m-%d')

      get "/answers/#{date}", {}, 'rack.session' => session

      expect(last_response).to be_ok
    end
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
