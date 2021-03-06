require 'bundler'
Bundler.require

require 'sinatra/activerecord/rake'

ActiveRecord::Base.establish_connection({
  adapter: 'postgresql',
  database: 'restaurant_db'
})

namespace :sinatra do
  desc "create a config.ru"
  task :config do
    text = <<-eos
require './app'
run Sinatra::Application
    eos
    File.write('config.ru', text)
  end

  desc "create an app.rb"
  task :app do
    text = <<-eos
require 'bundler'
Bundler.require

ROOT = Dir.pwd
Dir[ROOT+"/models/*.rb"].each	{ |file| require file }

get '/' do
  erb :index
end
    eos
    File.write('app.rb', text)
  end

  desc "create sinatra application"
  task :new => [:config, :app] do
    `bundle exec rackup`
  end
end

namespace :db do
  desc "create restaurant_db database"
  task :create_db do
    conn = PG::Connection.open()
    conn.exec('CREATE DATABASE restaurant_db;')
    conn.close
  end
  desc "drop restaurant_db database"
  task :drop_db do
    conn = PG::Connection.open()
    conn.exec('DROP DATABASE restaurant_db;')
    conn.close
  end
  desc "create junk data"
	task :junk_data do
    require_relative 'models/party'
    require_relative 'models/food'
    require_relative 'models/order'
    Food.create({name: 'Oxtail', cuisine: 'Jamaican', price: 12.99, allergens: 'none', spicy_level: '4'})
    Food.create({name: 'Stew Peas', cuisine: 'Jamaican', price: 10.99, allergens: 'none', spicy_level: '3'})
    Food.create({name: 'Saltfish & Callaloo', cuisine: 'Jamaican', price: 8.99, allergens: 'none', spicy_level: '3'})
    Food.create({name: 'Saltfish & Baked Beans', cuisine: 'Jamaican', price: 7.99, allergens: 'none', spicy_level: '4'})
    Food.create({name: 'Cornmeal Porridge', cuisine: 'Jamaican', price: 2.99, allergens: 'none', spicy_level: '1'})
    Food.create({name: 'Chicken Foot Soup', cuisine: 'Jamaican', price: 6.99, allergens: 'none', spicy_level: '4'})
    Food.create({name: 'Mannish Water', cuisine: 'Jamaican', price: 9.99, allergens: 'none', spicy_level: '5'})
    Food.create({name: 'Brown Stew Chicken', cuisine: 'Jamaican', price: 6.99, allergens: 'none', spicy_level: '3'})
    10.times { Party.create({surname: Faker::Name.last_name, table_num: rand(1..16), guests_num: rand(1..12)}) }
    parties = Party.all
    foods = Food.all
    parties.each do |party|
      party.guests_num.times do
        Order.create({party: party, food: foods.sample}) if [true, false].sample
      end
    end
  end
end
