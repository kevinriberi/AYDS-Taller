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
        
        # Obtener la primera pregunta del tema seleccionado
        first_question = Question.where(topic_id: topic_id).first
        
        # Redirigir al usuario a la página de la primera pregunta
        redirect "/questions/#{first_question.id}/answer"
      end
end