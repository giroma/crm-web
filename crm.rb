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

get '/contact/:id' do
  begin
    @contact = Contact.find(params[:id])
    erb :show_contact
  rescue
    raise Sinatra::NotFound
  end
end

# not_found do
#   "Nowhere to be found"
# end


after do
  ActiveRecord::Base.connection.close
end
