# require_relative '../models/user'

class RankingController < Sinatra::Application
  get '/ranking' do
    # Verifica si el usuario proviene del dashboard o esta accediendo directamente
    if session[:from_dashboard]
      # Calcula la pagina del usuario actual
      users_ordered = User.order(:points => :desc)
      current_user_index = users_ordered.index { |user| user.id == session[:user_id] }
      per_page = 10
      page = (current_user_index / per_page) + 1
      @users = users_ordered.paginate(:page => page, :per_page => per_page)
      session.delete(:from_dashboard) # Elimina la variable de sesion despues de usarla
    else
      # Si el usuario accede directamente, muestra la pagina del ranking que corresponda
      @users = User.order(:points => :desc).paginate(:page => params[:page], :per_page => 10)
    end
  
    erb :ranking
  end
end
