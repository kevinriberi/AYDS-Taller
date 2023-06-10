class AnswerController < Sinatra::Application

  post '/answers' do
    user_id = session[:user_id]
    question_id = params[:question_id]
    option_id = params[:option_id]

    # Verificar si el usuario ya respondió previamente la pregunta correctamente
    previous_answer = Answer.find_by(user_id: user_id, question_id: question_id)
    previous_answer_correct = previous_answer&.option_id == Question.find(question_id).correct_option_id

    # Crea una nueva instancia de Answer
    Answer.create(user_id: user_id, question_id: question_id, option_id: option_id)

    current_user = User.find(user_id)
    question = Question.find(question_id)
    option = Option.find(option_id)
    knowledge = Knowledge.find_by(user_id: user_id, topic_id: question.topic_id)

    if question.correct_option_id == option.id
      if previous_answer_correct
        flash[:success] = 'Respuesta correcta (ya respondida previamente)'
      else
        flash[:success] = '¡Respuesta correcta!'
        current_user.points += 10 * question.level.to_i
        current_user.save
        knowledge.correct_answers_count += 1

        # Verificar si se ha alcanzado el número de respuestas correctas requeridas para subir de nivel
        topic = Topic.find(question.topic_id)
        if knowledge.correct_answers_count == topic.amount_questions_L1
          knowledge.level += 1
          knowledge.correct_answers_count = 0
          knowledge.save
          flash[:success] = 'Has completado las preguntas de ese nivel'
        end
      end
    else
      flash[:error] = 'Respuesta incorrecta. ¡Vamos que en la próxima sale!'
      current_user.points -= 4 * question.level.to_i
      current_user.save
    end

    redirect '/'
  end
end
