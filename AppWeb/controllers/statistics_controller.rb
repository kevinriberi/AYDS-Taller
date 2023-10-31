require_relative '../models/user'

class StatisticsController < Sinatra::Application
  get '/history/:time_frame' do
    time_frame = params[:time_frame]
    end_date = Date.today
    user_id = session[:user_id]
    case time_frame
    when 'week'
      start_date = 7.days.ago.to_date
      respuestas = Answer.where("user_id = ? AND created_at >= ?", user_id, 7.day.ago)
      session[:ultimo_valor_seleccionado] = 'week'
    when 'month'
      start_date = 1.month.ago.to_date
      respuestas = Answer.where("user_id = ? AND created_at >= ?", user_id, 1.month.ago)
      session[:ultimo_valor_seleccionado] = 'month'
    when '3month'
      start_date = 3.month.ago.to_date
      respuestas = Answer.where("user_id = ? AND created_at >= ?", user_id, 3.month.ago)
      session[:ultimo_valor_seleccionado] = '3month'
    end

    date_range = (start_date..end_date).to_a.map { |date| date.strftime("%Y-%m-%d") }

    # Agrupa las respuestas por dia y calcula el puntaje acumulado para cada dia
    datos_grafico = respuestas.group("DATE(created_at)").sum(:points)

    # Crea un hash vacio para almacenar los datos del grafico
    @datos_grafico = []

    # Llena los valores de puntaje para cada dia en el conjunto de datos
    date_range.each do |fecha|
      respuesta = datos_grafico.find { |data| data[0] == fecha }
      @datos_grafico << if respuesta
                          { :fecha => fecha.to_date, :puntaje => respuesta[1] }
                        else
                          { :fecha => fecha.to_date, :puntaje => 0 }
                        end
    end

    erb :history
  end

  get '/answers/:date' do
    @date = Date.parse(params[:date])
    user_id = session[:user_id]  # Obten el ID del usuario de la sesion
    @topics = Topic.all
    @respuestas = Answer.where(:user_id => user_id, :created_at => @date.beginning_of_day..@date.end_of_day)
  
    erb :answers
  end
  
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