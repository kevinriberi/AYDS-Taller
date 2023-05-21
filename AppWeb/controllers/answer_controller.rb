class AnswerController < Sinatra::Application

  post '/answers' do
    user_id = session[:user_id]
    question_id = params[:question_id]
    option_id = params[:option_id]

    # Crea una nueva instancia de Answer
    answer = Answer.create(user_id: user_id, question_id: question_id, option_id: option_id)
    redirect '/questions'
  end
end