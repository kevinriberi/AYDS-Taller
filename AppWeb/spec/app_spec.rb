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

  context 'pruebas para /questions/:id/answer' do

    it 'debería mostrar la pregunta si el ID de la pregunta es válido' do
      # Crear un tema de prueba y obtener su ID
      topic = Topic.create(name: 'Test Topic', amount_questions_L1: 2, amount_questions_L2: 2, amount_questions_L3: 2)
      topic_id = topic.id

      # Crea una pregunta válida en tu base de datos y obtén su ID
      valid_question = Question.create(content: '¿Cuál es la capital de España?', topic_id: topic_id, level: 1)
      valid_question_id = valid_question.id

      # Realiza una solicitud GET simulada a la ruta /questions/:id/answer con un ID válido
      get "/questions/#{valid_question_id}/answer"

      # Verifica que el código de respuesta sea 200 (éxito)
      expect(last_response.status).to eq(200)

      # Verifica que la respuesta incluya el contenido esperado (por ejemplo, el formulario de respuesta)
      #expect(last_response.body).to include('¿Cuál es la capital de España?')  # Ajusta esto según el contenido real de la pregunta

      valid_question.destroy
      topic.destroy 
    end

    it 'debería devolver un error 404 si el ID de la pregunta no es válido' do
      # Crear un tema de prueba y obtener su ID
      topic = Topic.create(name: 'Test Topic', amount_questions_L1: 2, amount_questions_L2: 2, amount_questions_L3: 2)
      topic_id = topic.id

      # Crea una pregunta válida en tu base de datos y obtén su ID
      question = Question.create(content: '¿Cuál es la capital de Lituania?', topic_id: topic_id, level: 1)
      invalid_question_id = question.id

      question.destroy

      # Realiza una solicitud GET simulada a la ruta /questions/999/answer (ID inválido)
      get "/questions/#{invalid_question_id}/answer"

      # Verifica que el código de respuesta sea 404
      expect(last_response.status).to eq(404)

      # Verifica que la respuesta incluya un mensaje de error o contenido esperado
      expect(last_response.body).to include('Not Found') 

      topic.destroy
    end
  end

  context "se chequea si se recibe la vista correcta en la ruta /" do
    it 'debería renderizar la vista de dashboard si el usuario está autenticado' do

      user = User.create(username: 'test_user50', email: 'test50@example.com', password_digest: 'password123')
      session = { user_id: user.id } 

      # Simula que el usuario está autenticado llamando a la ruta '/'
      get '/', {}, 'rack.session' => session
    
      # Verifica que la respuesta sea exitosa (código 200)
      expect(last_response.status).to eq(200)
    
      # Verifica que la vista de dashboard se haya renderizado
      expect(last_response.body).to include('<h1>¡Hola, test_user50!</h1>')

      user.destroy
    end
    
    it 'debería renderizar la vista de índice si el usuario no está autenticado' do
      session = {}
      get '/', {}, 'rack.session' => session
    
      # Verifica que la respuesta sea exitosa (código 200)
      expect(last_response.status).to eq(200)
    
      expect(last_response.body).to include('<h1>Bienvenido a Prelude-Code!</h1>')
    end
  end

  context 'POST /answers' do
    it 'se responde una pregunta bien y no se sube de nivel' do
      topic = Topic.create(name: 'Test Topic', amount_questions_L1: 2, amount_questions_L2: 2, amount_questions_L3: 2)
      topic_id = topic.id

      user = User.create(username: 'test_user', email: 'test@example.com', password: 'password123') 

      knowledge = Knowledge.create(user: user, topic: topic, level: 1)

      question = Question.create(content: '¿Cuál es la capital de Francia?', topic_id: topic_id, level: 1) 
      option = Option.create(content: 'París', correct: true, question_id: question.id) 
      # Establece la sesión del usuario
      session = { user_id: user.id }

      # Realiza una solicitud POST a la ruta '/answers' con los parámetros necesarios
      post '/answers', { question_id: question.id, option_id: option.id }, 'rack.session' => session

      # Verifica si la respuesta es una redirección a la página de inicio
      expect(last_response.redirect?).to be true

      Answer.destroy_all
      knowledge.destroy
      option.destroy
      question.destroy
      topic.destroy
      user.destroy
    end

    it 'se responde una pregunta bien y se sube de nivel' do
      topic = Topic.create(name: 'Test Topic', amount_questions_L1: 1, amount_questions_L2: 1, amount_questions_L3: 1)
      topic_id = topic.id

      user = User.create(username: 'test_user', email: 'test@example.com', password: 'password123') 

      knowledge = Knowledge.create(user: user, topic: topic, level: 1)

      question = Question.create(content: '¿Cuál es la capital de Francia?', topic_id: topic_id, level: 1) 
      option = Option.create(content: 'París', correct: true, question_id: question.id) 
      # Establece la sesión del usuario
      session = { user_id: user.id }

      # Realiza una solicitud POST a la ruta '/answers' con los parámetros necesarios
      post '/answers', { question_id: question.id, option_id: option.id }, 'rack.session' => session

      # Verifica si la respuesta es una redirección a la página de inicio
      expect(last_response.redirect?).to be true

      Answer.destroy_all
      knowledge.destroy
      option.destroy
      question.destroy
      topic.destroy
      user.destroy
    end

    it 'se responde una pregunta bien y se completa el tema' do
      topic = Topic.create(name: 'Test Topic', amount_questions_L1: 2, amount_questions_L2: 2, amount_questions_L3: 2)
      topic_id = topic.id

      user = User.create(username: 'test_user', email: 'test@example.com', password: 'password123') 

      knowledge = Knowledge.create(user: user, topic: topic, level: 3, correct_answers_count: 1)

      question = Question.create(content: '¿Cuál es la capital de Francia?', topic_id: topic_id, level: 3) 
      option = Option.create(content: 'París', correct: true, question_id: question.id) 
      # Establece la sesión del usuario
      session = { user_id: user.id }

      # Realiza una solicitud POST a la ruta '/answers' con los parámetros necesarios
      post '/answers', { question_id: question.id, option_id: option.id }, 'rack.session' => session

      # Verifica si la respuesta es una redirección a la página de inicio
      expect(last_response.redirect?).to be true

      Answer.destroy_all
      knowledge.destroy
      option.destroy
      question.destroy
      topic.destroy
      user.destroy
    end

    it 'se responde una pregunta mal' do
      topic = Topic.create(name: 'Test Topic', amount_questions_L1: 1, amount_questions_L2: 1, amount_questions_L3: 1)
      topic_id = topic.id

      user = User.create(username: 'test_user', email: 'test@example.com', password: 'password123') 

      knowledge = Knowledge.create(user: user, topic: topic, level: 1)

      question = Question.create(content: '¿Cuál es la capital de Francia?', topic_id: topic_id, level: 1) 
      option = Option.create(content: 'París', correct: false, question_id: question.id) 
      # Establece la sesión del usuario
      session = { user_id: user.id }

      # Realiza una solicitud POST a la ruta '/answers' con los parámetros necesarios
      post '/answers', { question_id: question.id, option_id: option.id }, 'rack.session' => session

      # Verifica si la respuesta es una redirección a la página de inicio
      expect(last_response.redirect?).to be true

      Answer.destroy_all
      knowledge.destroy
      option.destroy
      question.destroy
      topic.destroy
      user.destroy
    end
  end

  context 'POST /login' do
    it 'debería autenticar al usuario y redirigirlo al inicio si las credenciales son válidas' do
      # Crear un usuario de prueba en la base de datos
      user = User.create(username: 'test_user', email: 'test@example.com', password: 'password123') 


      # Realizar una solicitud POST para iniciar sesión con credenciales válidas
      post '/login', { username: 'test_user', email: 'test@example.com', password: 'password123' }

      # Verificar que la respuesta sea una redirección
      expect(last_response).to be_redirect

      # Seguir la redirección
      follow_redirect!

      # Verificar que la solicitud redirigida sea a la página de inicio
      expect(last_request.path).to eq('/')

      user.destroy
    end

    it 'debería mostrar un mensaje de error si las credenciales son incorrectas' do
      # Crear un usuario de prueba en la base de datos
      user = User.create(username: 'test_user', email: 'test@example.com', password: 'password123') 

      # Realizar una solicitud POST para iniciar sesión con credenciales incorrectas
      post '/login', { username: 'test_user', email: 'test@example.com', password: '5555555' }

      # Verificar que la respuesta sea exitosa (código 200)
      expect(last_response).to be_ok

      # Verificar que la página de inicio contiene un mensaje de error
      #expect(last_response.body).to include('Usuario o contraseña incorrecta')

      user.destroy
    end
  end

  context 'POST /register' do
    it 'debería registrar un nuevo usuario y redirigirlo a la página de inicio de sesión' do
      # Realizar una solicitud POST para registrar un nuevo usuario
      post '/register', { username: 'nuevo_usuario', email: 'nuevo@example.com', password: 'password123', confirm_password: 'password123' }

      # Verificar que la respuesta sea una redirección
      expect(last_response).to be_redirect

      # Seguir la redirección
      follow_redirect!

      # Verificar que la solicitud redirigida sea a la página de inicio de sesión
      expect(last_request.path).to eq('/login')

      # Verificar que la página de inicio de sesión contiene un mensaje de éxito
      expect(last_response.body).to include('¡Te has registrado con éxito! ¡Inicia sesión para comenzar a jugar!')

      # También puedes verificar que el nuevo usuario se haya creado correctamente en la base de datos si lo deseas
      new_user = User.find_by(username: 'nuevo_usuario')
      expect(new_user).not_to be_nil

      new_user.destroy
    end

    it 'debería mostrar un mensaje de error si el nombre de usuario ya está tomado' do
      # Crear un usuario de prueba con el mismo nombre de usuario en la base de datos
      new_user = User.create(username: 'nuevo_usuario', email: 'otro@example.com', password: 'otra_password')

      # Realizar una solicitud POST para intentar registrar el mismo nombre de usuario
      post '/register', { username: 'nuevo_usuario', email: 'nuevo@example.com', password: 'password123', confirm_password: 'password123' }

      # Verificar que la respuesta contiene un mensaje de error
      expect(last_response.body).to include('El nombre de usuario ya está registrado')

      new_user.destroy
    end

    it 'debería mostrar un mensaje de error si el email usuario ya está tomado' do
      # Crear un usuario de prueba con el mismo email de usuario en la base de datos
      new_user = User.create(username: 'usuario_de_prueba', email: 'nuevo@example.com', password: 'otra_password')

      # Realizar una solicitud POST para intentar registrar el mismo nombre de usuario
      post '/register', { username: 'nuevo_usuario', email: 'nuevo@example.com', password: 'password123', confirm_password: 'password123' }

      # Verificar que la respuesta contiene un mensaje de error
      expect(last_response.body).to include('La dirección de email ya está registrada con otro usuario')

      new_user.destroy
    end

    it 'debería mostrar un mensaje de error si las contraseñas no coinciden' do
      # Realizar una solicitud POST con contraseñas que no coinciden
      post '/register', { username: 'nuevo_usuario', email: 'nuevo@example.com', password: 'password123', confirm_password: 'otraPassword' }

      # Verificar que la respuesta contiene un mensaje de error
      expect(last_response.body).to include('Las contraseñas no coinciden o estan vacias')

    end
  end




end