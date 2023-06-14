class AnswerController < Sinatra::Application

  post '/answers' do
    user_id = session[:user_id]
    question_id = params[:question_id]
    option_id = params[:option_id]

    # Crea una nueva instancia de Answer
    answer = Answer.create(user_id: user_id, question_id: question_id, option_id: option_id)

    current_user = User.find(user_id)
    question = Question.find(question_id)
    option = Option.find(option_id)
    knowledge = Knowledge.find_by(user_id: user_id, topic_id: question.topic_id)

    if option.correct
        flash[:success] = '¡Respuesta correcta!'
        current_user.points += 10 * question.level.to_i
        current_user.save
        knowledge.correct_answers_count += 1
    
        # Verificar si se ha alcanzado el número de respuestas correctas requeridas para subir de nivel
        topic = Topic.find(question.topic_id)
        if knowledge.correct_answers_count == 3
          knowledge.level += 1
          knowledge.correct_answers_count = 0
          if knowledge.level == 4
            flash[:success] = '¡Felicitaciones! ¡Completaste el tema!'
          else
            flash[:success] = '¡Felicitaciones! ¡Pasaste al siguiente nivel de dificultad!'
          end
        end
        knowledge.save
    else
        flash[:error] = 'Respuesta incorrecta. ¡Vamos que en la próxima sale!'
        current_user.points -= 4 * question.level.to_i
        current_user.save
    end

    answer.save
    redirect '/'
  end
end
