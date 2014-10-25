require 'bundler'
Bundler.require

require_relative 'connection'

ROOT = Dir.pwd
Dir[ROOT+"/models/*.rb"].each	{ |file| require file }

require_relative 'helpers/link_helper'
require_relative 'helpers/form_helper'

enable :sessions

get '/' do
	erb :index
end

get '/foods' do
	@foods = Food.all
	erb :"food/index"
end

get '/sessions/new' do
	erb :'sessions/new'
end

post '/users' do
	user = User.new(params[:user])
	user.password = params[:password]
	user.save!
	redirect '/foods'
end

get '/foods/new' do
	if session[:current_user]
		erb :"food/new"
	else
		redirect '/foods'
	end
end

get '/login' do
	erb :'sessions/login'
end

post '/sessions' do
	user = User.find_by({username: params[:username]})
	if user.password == params[:password]
		session[:current_user] = user.id
		redirect '/foods/new'
	else
		redirect '/foods'
	end
end

delete '/sessions' do
	session[:current_user] = nil
	redirect '/'
end

post '/foods' do
	food = Food.create(params[:food])
	if food.valid?
		redirect "/foods/#{food.id}"
	else
		@errors = food.errors.full_messages
		erb :'food/new'
	end
end

get '/foods/:id/edit' do
	@food = Food.find(params[:id])
	erb :'food/edit'
end

patch '/foods/:id' do
	food = Food.find(params[:id])
	food.update(params[:food])
	redirect "/foods/#{food.id}"
end

get '/foods/:id' do
	@food = Food.find(params[:id])
	erb :'food/show'
end

delete '/foods/:id' do
	Food.destroy(params[:id])
	redirect'/foods'
end

get '/parties' do
	@parties = Party.all
	erb :'party/index'
end

get '/parties/new' do
	erb :'party/new'
end

post '/parties' do
	party = Party.create(params[:party])
	redirect "/parties/#{party.id}"
end

get '/parties/:id/edit' do
	@party = Party.find(params[:id])
	erb :'party/edit'
end

patch '/parties/:id' do
	party = Party.find(params[:id])
	party.update(params[:party])
	redirect "/parties"
end

get '/parties/:id' do
	@party = Party.find(params[:id])
	@food = Food.find(params[:id])
	@party.foods
	erb :'party/show'
end

delete '/parties/:id' do
	@party = Party.find(params[:id])
	@orders = Order.all
	Party.destroy(params[:id])
	@orders.each do |order|
		if order.party_id == @party.id
			Order.destroy(order.id)
		end
	end
	redirect '/parties'
end

post '/orders' do
	# parties = Party.all
	@party = Party.find(params[:party_id])
	@food = Food.find(params[:id])
	@party.foods << @food
	redirect "/parties/#{@party.id}"
end

delete '/parties/:party_id/orders' do
	party_id = params[:party_id]
	Order.destroy(params[:order_id])
	redirect "/parties/#{party_id}"
end

get '/parties/:id/receipt' do
	@party = Party.find(params[:id])
	@food = Food.find(params[:id])
	@party.foods

	erb :'party/receipt'
end

patch '/parties/:id/checkout' do
	party = Party.find(params[:id])
	party.has_paid == true
	party.save
	redirect "/parties"
end


