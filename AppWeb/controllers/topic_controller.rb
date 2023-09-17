class TopicController < Sinatra::Application

# Ruta para redirigir al usuario a una pregunta aleatoria en un tema
  get '/topics/:id' do

    topic_id = params[:id]
    user = session[:user_id]

    # Verifica si el topic_id es válido (por ejemplo, existe en la base de datos)
    if Topic.find_by(id: topic_id)

      user_info = Knowledge.find_by(user: user, topic_id: topic_id)
      level = user_info.level
      questions = get_unanswered_questions(topic_id, level)
      question = questions.sample
      redirect "/questions/#{question.id}/answer"
    else
      status 404
      "Not Found"
    end
  end

  # Método para obtener las preguntas no respondidas por el usuario en un tema y nivel específicos
  def get_unanswered_questions(topic_id, level)
    user_id = session[:user_id]
    user = User.find(user_id)
    answered_questions = user.answers.joins(:option).where(options: { correct: true }).pluck(:question_id)
    Question.where(topic_id: topic_id, level: level).where.not(id: answered_questions).order("RANDOM()")
  end

end