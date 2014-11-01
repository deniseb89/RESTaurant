class ApplicationController < Sinatra::Base
  helpers Sinatra::AuthenticationHelper

  ActiveRecord::Base.establish_connection({
    adapter: 'postgresql',
    database: 'restaurant_db'
  })

  set :views, File.expand_path("../../views", __FILE__)
  set :public_folder, File.expand_path("../../public", __FILE__)

  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  post '/orders' do
    # parties = Party.all
    @party = Party.find(params[:party_id])
    @food = Food.find(params[:id])
    @party.foods << @food
    redirect "/parties/#{@party.id}"
  end

  not_found do
    halt 404, "I can't find that"
  end
end