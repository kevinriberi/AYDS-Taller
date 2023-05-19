class UserController < Sinatra::Application
     
  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/'
    else
      @error = "Usuario o contraseña incorrecta"
      erb :login
    end
  end

  post '/users' do
    @user = User.find_or_create_by(email: params[:email])

    erb :user
  end

  post '/guest' do
    guest = User.find_or_create_by(email: 'guest@example.com') do |u|
      u.password = 'guest_password'
    end
    session[:user_id] = guest.id
    redirect '/'
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  get '/register' do
    erb :register
  end
  
  post '/register' do
    # Crea un nuevo usuario con los datos del formulario
    user = User.new(email: params[:email], password: params[:password])
  
    # Si el usuario se guarda correctamente, redirigir a la página de inicio de sesión
    if user.save
      redirect '/login'
    else
      # Si hay un error, mostrar el mensaje de error en la página de registro
      @error = user.errors.full_messages.first
      erb :register
    end
  end

end