class TopicController < Sinatra::Application

  get '/topics/:id' do
    # Obtener el ID del tema seleccionado
    topic_id = params[:id]
    user_id = session[:user_id]

    user = User.find(user_id)
        
    # Obtener una pregunta aleatoria del tema seleccionado que se corresponda
    # con el nivel del usuario
    user_info = Knowledge.find_by(user_id: user_id, topic_id: topic_id)
    level = user_info.level
    answered_questions = user.answers.where(correct: true).pluck(:question_id)
    questions = Question.where(topic_id: topic_id, level: level).where.not(id: answered_questions).order("RANDOM()")
    question = questions.sample
    # Redirigir al usuario a la página de la pregunta seleccionada al azar
    redirect "/questions/#{question.id}/answer"
  end
end