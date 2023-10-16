class AnswerController < Sinatra::Application

  post '/answers' do
    user_id = session[:user_id]
    question_id = params[:question_id]
    option_id = params[:option_id]
    time = params[:time].to_i
    
    current_user = User.find(user_id)
    question = Question.find(question_id)
    option = Option.find(option_id)
    knowledge = Knowledge.find_by(user_id: user_id, topic_id: question.topic_id)

    current_user.update_streak(option.correct)
    current_user.save
    points = current_user.update_points(option.correct, question.level, time)
    current_user.save

    # Crea una nueva instancia de Answer
    answer = Answer.create(user_id: user_id, question_id: question_id, option_id: option_id, time: time, points: points )

    

    if option.correct 
      flash[:success] = '¡Respuesta correcta!'
      flash[:sound] = "/sounds/sound_correct_answer.mp3"
      flash[:gif] = ""
      if (knowledge.update_by_correct_answer)
        if (knowledge.is_finished)
          flash[:success] = '¡Felicitaciones! ¡Completaste el tema!'
          flash[:sound] = "/sounds/sound_all_levels_clear.mp3"
          flash[:gif] = "/images/confetti.gif"
        else
          flash[:success] = '¡Felicitaciones! ¡Pasaste al siguiente nivel de dificultad!'
          flash[:sound] = "/sounds/sound_level_up.mp3"
          end
        end
        knowledge.save
      else
        flash[:error] = 'Respuesta incorrecta. ¡Vamos que en la próxima sale!'
        flash[:sound] = "/sounds/sound_error.mp3"
      end
        
    answer.save
    redirect '/'
  end

  get '/answers/:date' do
    @date = Date.parse(params[:date])
    user_id = session[:user_id]  # Obtén el ID del usuario de la sesión
    @topics = Topic.all
    @respuestas = Answer.where(user_id: user_id, created_at: @date.beginning_of_day..@date.end_of_day)
  
    erb :answers
  end
  
end
