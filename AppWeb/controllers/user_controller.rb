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

  post '/users' do
    @user = User.find_or_create_by(username: params[:username])

    erb :user
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  get '/register' do
    erb :register
  end
  
  post '/register' do
    if username_taken?(params[:username])
      @error = 'El nombre de usuario ya está registrado'
      erb :register
    elsif email_taken?(params[:email])
      @error = 'La dirección de email ya está registrada con otro usuario'
      erb :register
    elsif passwords_match?(params[:password], params[:confirm_password])
      create_user(params[:username], params[:email], params[:password])
      flash[:success] = '¡Te has registrado con éxito! ¡Inicia sesión para comenzar a jugar!'
      redirect '/login'
    else
      @error = 'Las contraseñas no coinciden'
      erb :register
    end
  end

  get '/ranking' do
    @users = User.order(points: :desc).paginate(page: params[:page], per_page: 10)

    erb :ranking
  end
end



# definicion de metodos auxiliares

def username_taken?(username)
  User.exists?(username: username)
end

def email_taken?(email)
  User.exists?(email: email)
end

def passwords_match?(password, confirm_password)
  password == confirm_password
end

def create_user(username, email, password)
  user = User.new(username: username, email: email, password: password)
  user.save
  user.initialize_knowledges
end