require 'bundler'
Bundler.require

ROOT = Dir.pwd
Dir[ROOT+"/models/*.rb"].each	{ |file| require file }

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
	if food.valid?
		redirect "/foods/#{food.id}"
	else
		@errors = food.errors.full_messages
		erb :'foods/new'
	end
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
	redirect "/parties"
end

# show: Display a single party and options for adding a food item to the party
get '/parties/:id' do 
	@party = Party.find(params[:id])
	@food = Food.find(params[:id])	
	@party.foods
	erb :'parties/show'
end

# destroy: Removes a party
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



# create: Creates a new order
post '/orders' do 
	# parties = Party.all
	@party = Party.find(params[:party_id])
	@food = Food.find(params[:id])	
	@party.foods << @food
	redirect "/parties/#{@party.id}"		
end

# destroy: Removes an order
delete '/parties/:party_id/orders' do 
	party_id = params[:party_id]
	Order.destroy(params[:order_id])
	redirect "/parties/#{party_id}"
end



# /parties/:id/receipt: Saves the party's receipt data to a file. Displays the content of the receipt. Offer the file for download.
get '/parties/:id/receipt' do 
	@party = Party.find(params[:id])
	@food = Food.find(params[:id])
	@party.foods 

	erb :'parties/receipt'
end
		
# /parties/:id/checkout: Marks the party as paid
patch '/parties/:id/checkout' do 
	party = Party.find(params[:id])
	party.pay_status == true
	party.save
	redirect "/parties"
end



