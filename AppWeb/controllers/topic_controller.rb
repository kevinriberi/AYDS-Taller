class TopicController < Sinatra::Application

# Ruta para redirigir al usuario a una pregunta aleatoria en un tema
  get '/topics/:id' do

    topic_id = get_topic_id
    user = get_current_user
    level = get_user_level(topic_id)
    questions = get_unanswered_questions(topic_id, level)
    question = questions.sample
    redirect "/questions/#{question.id}/answer"
  end
end

# Método para obtener el ID del tema seleccionado
def get_topic_id
  params[:id]
end

# Método para obtener el ID del usuario actualmente autenticado
def get_user_id
  session[:user_id]
end

# Método para obtener el usuario actualmente autenticado
def get_current_user
  user_id = get_user_id
  User.find(user_id)
end

# Método para obtener el nivel del usuario en un tema específico
def get_user_level(topic_id)
  user_id = get_user_id
  user_info = Knowledge.find_by(user_id: user_id, topic_id: topic_id)
  user_info.level
end

# Método para obtener las preguntas no respondidas por el usuario en un tema y nivel específicos
def get_unanswered_questions(topic_id, level)
  user = get_current_user
  answered_questions = user.answers.joins(:option).where(options: { correct: true }).pluck(:question_id)
  Question.where(topic_id: topic_id, level: level).where.not(id: answered_questions).order("RANDOM()")
end