require 'bundler'
Bundler.require

Dir.glob('./controllers/*.rb').each do |file|
	require file
	puts "required #{file}"
end

map('/foods'){ run FoodsController }
map('/parties'){ run PartiesController }
map('/'){ run ApplicationController }