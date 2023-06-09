class TopicController < Sinatra::Application
    get '/topics' do        
        @topics = Topic.all
        
        erb :'topic/topics'
      end
    
      get '/topics/new' do
        @topic = Topic.new

        erb :'topic/new_topic'
      end
    
      post '/topics' do
        @topic = Topic.new(params[:topic])
        if @topic.save
          redirect '/topics'
        else
          erb :'topic/new_topic'
        end
      end
    
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
end