# spec/app_spec.rb
require 'rack/test'

RSpec.describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    # incluir el nombre de la clase correspondiente a la Application definida en el server.rb
    App
  end

  it 'probando rutas del server' do
    get '/' # Accede a la ruta '/' 
    expect(last_response.status).to eq(200) # Verifica el código de respuesta HTTP
  end
end