class AnswerController < Sinatra::Application

  post '/answers' do
    user_id = session[:user_id]
    question_id = params[:question_id]
    option_id = params[:option_id]
    time = params[:time]

    # Crea una nueva instancia de Answer
    answer = Answer.create(user_id: user_id, question_id: question_id, option_id: option_id, time: time )

    current_user = User.find(user_id)
    question = Question.find(question_id)
    option = Option.find(option_id)
    knowledge = Knowledge.find_by(user_id: user_id, topic_id: question.topic_id)

    current_user.update_points(option.correct, question.level, answer.time)
    current_user.update_streak(option.correct)
    current_user.save

    if option.correct 
        flash[:success] = '¡Respuesta correcta!'
        if (knowledge.update_by_correct_answer)
          if (knowledge.is_finished)
            flash[:success] = '¡Felicitaciones! ¡Completaste el tema!'
          else
            flash[:success] = '¡Felicitaciones! ¡Pasaste al siguiente nivel de dificultad!'
          end
        end
        knowledge.save
    else
      flash[:error] = 'Respuesta incorrecta. ¡Vamos que en la próxima sale!'
    end
        
    answer.save
    redirect '/'
  end
end
