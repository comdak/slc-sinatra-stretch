require 'sinatra'
require 'sequel'
DB = Sequel.connect('sqlite://db/contacts.db')

class Contact < Sequel::Model
end


get '/' do
  @title = "Home"
  @content = "Welcome to the Super(tm) Contact List"
  @contacts = Contact.all
  erb :index
end

post '/' do
  favorite = params[:favorite] == 'true'

  Contact.create(
    company: params[:company],
    firstname: params[:firstname],
    lastname: params[:lastname],
    straddress: params[:straddress],
    city: params[:city],
    stateprov: params[:stateprov],
    phone: params[:phone],
    email: params[:email],
    notes: params[:notes],
    favorite: favorite,
  )
  redirect '/'
end

get '/contacts/:id' do

  # @id = params[:id]
  @contact = Contact[params[:id]]

  if @contact.nil?
      @title = "Not Found"
      @content = "Avast, ye scalleywag! No card be found in these here parts."
      erb :error
    else
      @title = "Contact Details"
      erb :show
    end
end

get '/edit/:id' do
  @title = "Edit"
  @contact = Contact[params[:id]]

  if @contact.nil?
    @content = "Avast, ye scalleywag! Ye cannot edit that which can not be found"
    erb :error
  else
    erb :edit
  end
end

put '/edit/:id' do
  @contact = Contact[params[:id]]
  favorite = params[:favorite] == 'true'

  @contact.update(
  company: params[:company],
  firstname: params[:firstname],
  lastname: params[:lastname],
  straddress: params[:straddress],
  city: params[:city],
  stateprov: params[:stateprov],
  phone: params[:phone],
  email: params[:email],
  notes: params[:notes],
  favorite: favorite,
  )

  redirect "/contacts/#{params[:id]}"
end

get '/delete/:id' do
  @title = "Delete Contact"
  @contact = Contact[params[:id]]

  if @contact.nil?
    @content = "How do you kill that which has no life?"
    erb :error
  else
    erb :delete
  end
end

delete '/delete/:id' do
  @note = Contact[params[:id]]
  @note.destroy

  redirect '/'
end
