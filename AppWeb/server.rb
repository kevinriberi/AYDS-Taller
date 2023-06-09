require 'bundler/setup'
require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/activerecord'
require 'rack/session/cookie'
require 'logger'
require 'sinatra/reloader' if Sinatra::Base.environment == :development
require_relative 'models/user'
require_relative 'models/question'
require_relative 'models/option'
require_relative 'models/topic'
require_relative 'models/answer'
#require_relative 'models/knowledge'
require_relative 'controllers/question_controller'
require_relative 'controllers/topic_controller'
require_relative 'controllers/answer_controller'
require_relative 'controllers/user_controller'

set :database, {adapter: "sqlite3", database: "my-project.sqlite3"}

class App < Sinatra::Application

  set :views, Proc.new { File.join(root, 'views') }
  use Rack::Session::Cookie, key: 'prelude_code_session',
                             expire_after: 60 * 60, #1 hora
                             secret: '5cQK8KJmpxqm3PBZQfpBgX3wb7U9x8R6NNLHU2cqTVcBSh9x7pdXa7eYrA9T4pbG'

  use QuestionController
  use TopicController
  use AnswerController
  use UserController

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
      @topics = Topic.all
      erb :dashboard
    else
      erb :index
    end
  end

end