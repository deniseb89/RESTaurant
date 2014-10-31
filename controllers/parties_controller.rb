class PartiesController < ApplicationController

	get '/parties' do
		@parties = Party.all
		erb :'parties/index'
	end

	get '/parties/new' do
		erb :'parties/new'
	end

	post '/parties' do
		party = Party.create(params[:party])
		redirect "/parties/#{party.id}"
	end

	get '/parties/:id/edit' do
		@party = Party.find(params[:id])
		erb :'parties/edit'
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
		erb :'parties/show'
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

	delete '/parties/:party_id/orders' do
		party_id = params[:party_id]
		Order.destroy(params[:order_id])
		redirect "/parties/#{party_id}"
	end

	get '/parties/:id/receipt' do
		@party = Party.find(params[:id])
		@food = Food.find(params[:id])
		@party.foods
		erb :'parties/receipt'
	end

	patch '/parties/:id/checkout' do
		party = Party.find(params[:id])
		party.pay_status == true
		party.save
		redirect "/parties"
	end
end