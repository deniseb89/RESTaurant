require 'bundler'
Bundler.require(:default)

Dir.glob('./{helpers,models,controllers}/*.rb').each do |file|
	require file
	puts "required #{file}"
end

map('/foods'){run FoodsController}
map('/sessions'){run SessionsController}
map('/parties'){ run PartiesController }
map('/'){ run ApplicationController }