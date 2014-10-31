class SessionsController < ApplicationController
# *****EDIT ROUTES TO REFLECT THAT EVERYTHING NOW STARTS WITH /SESSIONS*****
	get '/sessions/new' do
		erb :'sessions/new'
	end

	post '/users' do
		user = User.new(params[:user])
		user.password = params[:password]
		user.save!
		redirect '/foods'
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
end
