class TopicController < Sinatra::Application

  get '/topics/:id' do
    # Obtener el ID del tema seleccionado
    topic_id = params[:id]
    user_id = session[:user_id]
        
    # Obtener una pregunta aleatoria del tema seleccionado que se corresponda
    # con el nivel del usuario
    user_info = Knowledge.find_by(user_id: user_id, topic_id: topic_id)
    level = user_info.level
    questions = Question.where(topic_id: topic_id, level: level).order("RANDOM()")
    question = questions.sample
      
    # Redirigir al usuario a la página de la pregunta seleccionada al azar
    redirect "/questions/#{question.id}/answer"
  end

    # Obtener las preguntas que aún no ha respondido correctamente
    answered_questions = user_info.knowledge_questions.where(correct: true).pluck(:question_id)
    questions = Question.where(topic_id: topic_id, level: level).where.not(id: answered_questions).order("RANDOM()")
    question = questions.sample
end