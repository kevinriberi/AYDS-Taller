require_relative '../models/answer'

class QuestionController < Sinatra::Application
  
  # Ruta para mostrar la pregunta individual y su formulario de respuesta
  get '/questions/:id/answer' do
    question_id = params[:id]

    if Question.find_by(id: question_id)

      @question = Question.find(params[:id])

      erb :answer
    else
      status 404
      "Not Found"
    end   
  end
end