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

post '/add_contact' do
  Contact.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    note: params[:note]
  )

  redirect to('/')
end

get '/contact/:id' do
  begin
    @contact = Contact.find(params[:id])
    erb :show_contact
  rescue
    raise Sinatra::NotFound
  end
end

get '/edit_contact/:id' do
  begin
    @contact = Contact.find(params[:id])
    erb :edit_contact
  rescue
    raise Sinatra::NotFound
  end
end

put '/edit_contact/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
 if @contact
   @contact.update(
   first_name: params[:first_name],
   last_name:  params[:last_name],
   email:      params[:email],
   note:       params[:note]
   )

   redirect to('/')
 else
   raise Sinatra::NotFound
 end
end

get '/delete/:id' do
  begin
    @contact = Contact.find(params[:id])
    erb :delete
  rescue
    raise Sinatra::NotFound
  end
end

delete '/delete/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    @contact.delete
    redirect to('/')
  else
    raise Sinatra::NotFound
  end
end


after do
  ActiveRecord::Base.connection.close
end
