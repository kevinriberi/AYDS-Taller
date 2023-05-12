require 'bundler/setup'
require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/activerecord'
require_relative 'models/user'
require_relative 'models/question'
require_relative 'models/option'
require_relative 'models/topic'

require 'logger'

set :database, {adapter: "sqlite3", database: "my-project.sqlite3"}

class App < Sinatra::Application
  configure :production, :development do
    enable :logging
    enable :sessions

    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end

  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded!!!'
      logger.info 'Reloaded!!!'
    end
  end

  def logged_in?
    session[:user_id] != nil
  end

  def current_user
    User.find(session[:user_id])
  end
  
  get '/' do
    if logged_in?
      @user = current_user
      erb :dashboard
    else
      erb :index
    end
  end

  post '/users' do
    @user = User.find_or_create_by(email: params[:email])

    erb :user
  end

  get '/users' do
    @users = User.all

    erb :users
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/'
    else
      @error = "Usuario o contraseña incorrecta"
      erb :login
    end
  end

  post '/guest' do
    guest = User.find_or_create_by(email: 'guest@example.com') do |u|
      u.password = 'guest_password'
    end
    session[:user_id] = guest.id
    redirect '/'
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  get '/register' do
    erb :register
  end
  
  post '/register' do
    # Crea un nuevo usuario con los datos del formulario
    user = User.new(email: params[:email], password: params[:password])
  
    # Si el usuario se guarda correctamente, redirigir a la página de inicio de sesión
    if user.save
      redirect '/login'
    else
      # Si hay un error, mostrar el mensaje de error en la página de registro
      @error = user.errors.full_messages.first
      erb :register
    end
  end

  get '/topics' do
    @topics = Topic.all
    erb :topics
  end
    
  get '/questions/new' do
    @question = Question.new
    @topics = Topic.all
    erb :new_question
  end
  
  post '/questions' do
    @question = Question.new(params[:question])
    if @question.save
      redirect '/questions'
    else
      erb :new_question
    end
  end
  
  get '/questions/:id' do
    @question = Question.find(params[:id])
    @options = @question.options
    erb :question
  end

  
  get '/questions/:id/edit' do
    @question = Question.find(params[:id])
    @topics = Topic.all
    erb :edit_question
  end
  
  put '/questions/:id' do
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      redirect '/questions'
    else
      erb :edit_question
    end
  end
  
  delete '/questions/:id' do
    @question = Question.find(params[:id])
    @question.destroy
    redirect '/questions'
  end

  get '/questions' do
    @topics = Topic.all
    erb :questions
  end

  get '/topics/new' do
    @topic = Topic.new
    erb :new_topic
  end

  post '/topics' do
    @topic = Topic.new(params[:topic])
    if @topic.save
      redirect '/topics'
    else
      erb :new_topic
    end
  end

  get '/topics/:id' do
    @topic = Topic.find(params[:id])
    @questions = @topic.questions

    erb :topic
  end

  post '/questions/:id/options' do
    @question = Question.find(params[:id])
    @option = @question.options.new(params[:option])
    if @option.save
      redirect "/questions/#{params[:id]}"
    else
      erb :question
    end
  end

  get '/question_options/:id' do
    @question = Question.find(params[:id])
    @options = @question.options
    erb :question_options
  end

end