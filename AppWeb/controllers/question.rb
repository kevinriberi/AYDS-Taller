class QuestionController < Sinatra::Application

    # Ruta para mostrar todas las preguntas
    get '/questions' do
      @questions = Question.all
      @topics = Topic.all

      erb :'question/questions'
    end
  
    # Ruta para mostrar el formulario de nueva pregunta
    get '/question/new' do
      @question = Question.new
      @topics = Topic.all

      erb :'question/new_question'
    end
  
    # Ruta para crear una nueva pregunta
    post '/questions' do
      options = [
        Option.new(content: params[:option1]),
        Option.new(content: params[:option2]),
        Option.new(content: params[:option3]),
        Option.new(content: params[:option4])
      ]
  
      @question = Question.new(params[:question])
      @question.topic = Topic.find(params[:topic])
      @question.options = options
  
      if @question.save
        redirect '/questions'
      else
        @topics = Topic.all
        erb :'question/new_question'
      end
    end
  
    # Ruta para mostrar una pregunta individual
    get '/questions/:id' do
      @question = Question.find(params[:id])
      erb :'question/question'
    end
  
    # Ruta para mostrar el formulario de edición de una pregunta
    get '/question/:id/edit' do
      @question = Question.find(params[:id])
      @topics = Topic.all
      erb :'questions/question'
    end
  
    # Ruta para actualizar una pregunta existente
    put '/questions/:id' do
      options = [
        Option.new(content: params[:option1]),
        Option.new(content: params[:option2]),
        Option.new(content: params[:option3]),
        Option.new(content: params[:option4])
      ]
  
      @question = Question.find(params[:id])
      @question.update(params[:question])
      @question.topic = Topic.find(params[:topic])
      @question.options = options
  
      if @question.save
        redirect '/questions'
      else
        @topics = Topic.all
        erb :'question/question'
      end
    end
  
    # Ruta para eliminar una pregunta existente
    delete '/questions/:id' do
      @question= Question.find(params[:id])
      @question.destroy
      redirect '/questions'
    end
  end
  