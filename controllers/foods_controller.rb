class FoodsController < ApplicationControler
# *****EDIT ROUTES TO REFLECT THAT EVERYTHING NOW STARTS WITH /SESSIONS*****

	get '/foods' do
		@foods = Food.all
		erb :"foods/index"
	end

	get '/foods/new' do
		authenticate!
		erb :"foods/new"
	end

	post '/foods' do
		food = Food.create(params[:food])
		if food.valid?
			redirect "/foods/#{food.id}"
		else
			@errors = food.errors.full_messages
			erb :'foods/new'
		end
	end

	get '/foods/:id/edit' do
		@food = Food.find(params[:id])
		erb :'foods/edit'
	end

	patch '/foods/:id' do
		food = Food.find(params[:id])
		food.update(params[:food])
		redirect "/foods/#{food.id}"
	end

	get '/foods/:id' do
		@food = Food.find(params[:id])
		erb :'foods/show'
	end

	delete '/foods/:id' do
		Food.destroy(params[:id])
		redirect'/foods'
	end
end