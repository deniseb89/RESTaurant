class ApplicationController < Sinatra::Base

	ROOT = Dir.pwd
	Dir[ROOT+"/models/*.rb"].each	{ |file| require file }
	require_relative 'connection'

	set :views, File.expand_path("../../views", __FILE__)
	enable :sessions

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

	# not_found do
	# 	halt 404, "I can't find that"
	# end
end