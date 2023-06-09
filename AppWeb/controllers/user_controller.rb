class UserController < Sinatra::Application
     
  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/'
    else
      @error = "Usuario o contraseña incorrecta"
      erb :login
    end
  end

  post '/users' do
    @user = User.find_or_create_by(username: params[:username])

    erb :user
  end

  post '/guest' do
    guest = User.find_or_create_by(username: 'Invitad@') do |u|
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
    # Verificar si el nombre de usuario ya está registrado
    if User.exists?(username: params[:username])
      @error = 'El nombre de usuario ya está registrado'
      erb :register
    else
      # Verificar si las contraseñas coinciden
      if params[:password] == params[:confirm_password]
        # Crear un nuevo usuario con los datos del formulario
        user = User.new(username: params[:username], password: params[:password])
  
        # Si el usuario se guarda correctamente, redirigir a la página de inicio de sesión
        if user.save
          redirect '/login'
        else
          # Si hay un error, mostrar el mensaje de error en la página de registro
          @error = user.errors.full_messages.first
          erb :register
        end
      else
        @error = 'Las contraseñas no coinciden'
        erb :register
      end
    end
  end

end