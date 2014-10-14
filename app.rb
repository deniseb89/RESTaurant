require 'bundler'
Bundler.require

require_relative 'models/food'
require_relative 'models/party'
require_relative 'models/order'

ActiveRecord::Base.establish_connection({
	adapter: 'postgresql',
	database: 'restaurant_db'
	})

# index: Displays links to navigate the application (including links to each current parties)
get '/' do 
	erb :index
end

# index: Display all the available foods
get '/foods' do 
	@foods = Food.all 
	erb :"foods/index"
end

# new: Return a form for a new food
get '/foods/new' do 
	erb :"foods/new"
end

# create: Creates a new food
post '/foods' do 
	food = Food.create(params[:food])
	redirect "/foods/#{food.id}"
end

# edit: Returns a form to edit a food
get '/foods/:id/edit' do 
	@food = Food.find(params[:id])
	erb :'foods/edit'
end

# update: Updates an existing food
patch '/foods/:id' do 
	food = Food.find(params[:id])
	food.update(params[:food])
	redirect "/foods/#{food.id}"
end

# show: Display a single food item and a list of all the parties that included it
get '/foods/:id' do 
	@food = Food.find(params[:id])
	erb :'foods/show'
end

# destroy: Removes a food 
delete '/foods/:id' do 
	Food.destroy(params[:id])
	redirect'/foods'
end




# index: Display all the parties
get '/parties' do 
	@parties = Party.all 
	erb :'parties/index'
end

# new: Return a form for a new party
get '/parties/new' do 
	erb :'parties/new'
end

# create: Creates a new party
post '/parties' do 
	party = Party.create(params[:party])
	redirect "/parties/#{party.id}"
end

# edit: Returns a form to edit a party's details
get '/parties/:id/edit' do 
	@party = Party.find(params[:id])
	erb :'parties/edit'
end

# update: Updates an existing party's details
patch '/parties/:id' do 
	party = Party.find(params[:id])
	party.update(params[:party])
	redirect "/parties/#{party.id}"
end

# show: Display a single party and options for adding a food item to the party
get '/parties/:id' do 
	@party = Party.find(params[:id])
	@food = Food.find(params[:id])	
	erb :'parties/show'
end

# destroy: Removes a party
delete '/parties/:id' do 
	Party.destroy(params[:id])
	redirect '/parties'
end




# create: Creates a new order
post '/orders' do 
	party = Party.find(params[:party_id])
	food = Food.find(params[:id])
	party.foods << food
	redirect "/parties/#{party.id}"
end

# edit: Change an item to no-charge


# destroy: Removes an order





# /parties/:id/receipt: Saves the party's receipt data to a file. Displays the content of the receipt. Offer the file for download.



# /parties/:id/checkout: Marks the party as paid



