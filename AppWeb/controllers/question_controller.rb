require_relative '../models/answer'

class QuestionController < Sinatra::Application
  
  # Ruta para mostrar la pregunta individual y su formulario de respuesta
  get '/questions/:id/answer' do
    @question = Question.find(params[:id])

    erb :answer
  end
end