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
    @users = User.order(points: :desc).paginate(page: params[:page], per_page: 10)

    erb :ranking
  end
end

