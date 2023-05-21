require_relative '../models/answer'

class QuestionController < Sinatra::Application

    # Ruta para mostrar todas las preguntas
    get '/questions' do
      @questions = Question.all
      @topics = Topic.all

      erb :'question/questions'
    end
  
    # Ruta para mostrar el formulario de nueva pregunta
    get '/questions/new' do
      @question = Question.new
      @topics = Topic.all

      erb :'question/new_question'
    end
  
    # Ruta para crear una nueva pregunta
    post '/questions' do
      # crea una nueva pregunta
      question = Question.create(content: params[:question], topic_id: params[:topic], level: params[:level] )
    
      # crea las opciones de la pregunta
      option1 = Option.create(content: params[:option1])
      option2 = Option.create(content: params[:option2])
      option3 = Option.create(content: params[:option3])
    
      # actualiza la opción correcta de la pregunta
      if params[:correct_option] == '1'
        question.update(correct_option_id: option1.id)
      elsif params[:correct_option] == '2'
        question.update(correct_option_id: option2.id)
      elsif params[:correct_option] == '3'
        question.update(correct_option_id: option3.id)
      end
    
      option1.update(question_id: question.id)
      option2.update(question_id: question.id)
      option3.update(question_id: question.id)
      # redirige a la página de todas las preguntas
      redirect '/questions/new'
    end
  
    # Ruta para mostrar una pregunta individual
    get '/questions/:id' do
      @question = Question.find(params[:id])
      @options = @question.options

      erb :'question/question'
    end

    # Ruta para mostrar la pregunta individual y su formulario de respuesta
    get '/questions/:id/answer' do
      @question = Question.find(params[:id])

      erb :'answer'
    end

end