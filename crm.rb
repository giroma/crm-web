require 'sinatra'
require_relative 'contact'

get '/' do
  redirect to('/index')
end

get '/index' do
  @list = Contact.all
  erb :index
end

get '/about' do
    erb :about
end

get '/add_contact' do

  erb :add_contact
end


after do
  ActiveRecord::Base.connection.close
end
