class AnswerController < Sinatra::Application

  post '/answers' do
    user_id = session[:user_id]
    question_id = params[:question_id]
    option_id = params[:option_id]

    # Crea una nueva instancia de Answer
    Answer.create(user_id: user_id, question_id: question_id, option_id: option_id)

    current_user = User.find(user_id)
    question = Question.find(params[:question_id])
    option = Option.find(params[:option_id])

    if question.correct_option_id == option.id
      @message = 'Respuesta correcta'
      current_user.points += 10 * question.level.to_i
      current_user.save
    else
      @message = 'Respuesta incorrecta'
      current_user.points -= 4 * question.level.to_i
      current_user.save
    end

    redirect '/'

  end
end

