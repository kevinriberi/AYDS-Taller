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
    it 'se accede a la ruta principal' do
      get '/' # Accede a la ruta '/' 
      expect(last_response.status).to eq(200) # Verifica el código de respuesta HTTP
    end

    it 'se accede a la ruta de login' do
      get '/login' # Accede a la ruta '/' 
      expect(last_response.status).to eq(200) # Verifica el código de respuesta HTTP
    end

    it 'se accede a la ruta de registro' do
      get '/register' # Accede a la ruta '/register' 
      expect(last_response.status).to eq(200) # Verifica el código de respuesta HTTP
    end

    it 'se accede a la ruta de ranking' do
      get '/ranking' # Accede a la ruta '/register' 
      expect(last_response.status).to eq(200) # Verifica el código de respuesta HTTP
    end
  end

  context 'probando la ruta /topics/:id' do

    it 'debería redirigir a una pregunta si el topic_id es válido' do
      # Crear un tema de prueba y obtener su ID
      topic = Topic.create(name: 'Test Topic', amount_questions_L1: 2, amount_questions_L2: 2, amount_questions_L3: 2)
      topic_id = topic.id

      # Crear una pregunta asociada al tema de nivel 1
      question = Question.create(content: '¿Cuál es la capital de Francia?', topic_id: topic_id, level: 1)

      # Crear un usuario de prueba y obtener su ID
      user = User.create(username: 'test_user10', email: 'testttttt@example.com', password_digest: 'password123')
      knowledge = Knowledge.create(user: user, topic: topic, level: 1)
      session = { user_id: user.id } 
      # Llama a la ruta con el topic_id válido y la sesión
      get "/topics/#{topic_id}", {}, 'rack.session' => session

      # Verifica si la respuesta es una redirección a una pregunta
      expect(last_response.redirect?).to be true
      # Verifica el código de redirección (302 suele ser el código para redirección)
      expect(last_response.status).to eq(302)

      knowledge.destroy
      question.destroy
      topic.destroy
      user.destroy

    end

    it 'debería devolver un error 404 si el topic_id no es válido' do
      topic = Topic.create(name: 'Test Topic and Destroy', amount_questions_L1: 2, amount_questions_L2: 2, amount_questions_L3: 2)
      topic_id = topic.id
      topic.destroy

      user = User.create(username: 'test_user30', email: 'testttttt2222@example.com', password_digest: 'password123')
      session = { user_id: user.id } 

      # Llama a la ruta con el topic_id inválido y la sesión
      get "/topics/#{topic_id}", {}, 'rack.session' => session

      # Verifica si la respuesta es un error 404
      expect(last_response.status).to eq(404)
      # Verifica si el mensaje de error es el esperado
      expect(last_response.body).to include('Not Found')

      user.destroy
    end

  end
end