require_relative '../models/user'

class UserController < Sinatra::Application

     
  get '/login' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/'
    else
      @error = "Usuario o contraseña incorrecta"
      erb :index
    end
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  get '/register' do
    erb :register
  end
  
  post '/register' do
    if User.username_taken?(params[:username])
      @error = 'El nombre de usuario ya está registrado'
      erb :register
    elsif User.email_taken?(params[:email])
      @error = 'La dirección de email ya está registrada con otro usuario'
      erb :register
    elsif User.passwords_match?(params[:password], params[:confirm_password])
      user = User.create(username: params[:username], email: params[:email], password: params[:password])
      user.initialize_knowledges
      flash[:success] = '¡Te has registrado con éxito! ¡Inicia sesión para comenzar a jugar!'
      redirect '/login'
    else
      @error = 'Las contraseñas no coinciden o estan vacias'
      erb :register
    end
  end

  get '/ranking' do
    # Verifica si el usuario proviene del dashboard o está accediendo directamente
    if session[:from_dashboard]
      # Calcula la página del usuario actual
      users_ordered = User.order(points: :desc)
      current_user_index = users_ordered.index { |user| user.id == session[:user_id] }
      per_page = 10
      page = (current_user_index / per_page) + 1
      @users = users_ordered.paginate(page: page, per_page: per_page)
      session.delete(:from_dashboard) # Elimina la variable de sesión después de usarla
    else
      # Si el usuario accede directamente, muestra la página del ranking que corresponda
      @users = User.order(points: :desc).paginate(page: params[:page], per_page: 10)
    end
  
    erb :ranking
  end

  get '/history' do
    # Obtén el rango de fechas de los últimos 7 días
    end_date = Date.today
    start_date = 7.days.ago.to_date
    date_range = (start_date..end_date).to_a.map { |date| date.strftime("%Y-%m-%d") }

    # Obtén las respuestas de los últimos 7 días para un usuario específico (reemplaza user_id con el ID del usuario)
    user_id = session[:user_id]
    respuestas = Answer.where("user_id = ? AND created_at >= ?", user_id, 7.days.ago)

    # Agrupa las respuestas por día y calcula el puntaje acumulado para cada día
    datos_grafico = respuestas.group("DATE(created_at)").sum(:points)

    # Crea un hash vacío para almacenar los datos del gráfico
    @datos_grafico = []

    # Llena los valores de puntaje para cada día en el conjunto de datos
    date_range.each do |fecha|
      respuesta = datos_grafico.find { |data| data[0] == fecha }
      if respuesta
        @datos_grafico << { fecha: fecha.to_date, puntaje: respuesta[1] }
      else
        @datos_grafico << { fecha: fecha.to_date, puntaje: 0 }
      end
    end

    erb :history
  end
end
