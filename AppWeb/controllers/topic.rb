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
        @topic = Topic.find(params[:id])
        @questions = @topic.questions
    
        erb :'topic/topic'
      end
end