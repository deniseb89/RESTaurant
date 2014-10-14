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


# update: Updates an existing food


# show: Display a single food item and a list of all the parties that included it
get '/foods/:id' do 
	@food = Food.find(params[:id])
	erb :'foods/show'

# destroy: Removes a food 





# index: Display all the parties


# new: Return a form for a new party


# create: Creates a new party


# edit: Returns a form to edit a party's details


# update: Updates an existing party's details


# show: Display a single party and options for adding a food item to the party


# destroy: Removes a party





# create: Creates a new order


# edit: Change an item to no-charge


# destroy: Removes an order





# /parties/:id/receipt: Saves the party's receipt data to a file. Displays the content of the receipt. Offer the file for download.



# /parties/:id/checkout: Marks the party as paid



