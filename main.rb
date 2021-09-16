     
require 'sinatra'
require 'sinatra/reloader' #if development?
require_relative "methods/user.rb"
require 'pg'
require 'bcrypt'
enable :sessions

get '/' do
  erb :login, layout: false
end

post '/session' do
  user = find_user_by_email(params["email"])
  if user && BCrypt::Password.new(user["password_digest"]) == params["password"]
  session["id"] = user["id"]
  redirect '/home'
  else
    redirect '/'
  end
end

get '/signin' do
  erb :signin, layout: false
end

post '/new_user' do
  if check_email(params["email"])
      "<a href='/signin'>Return</a> <p>It looks like the email <strong>#{params["email"]} </strong>has already been taken, please sign in with another email.</p><p>If you have lost your password, please send an email to <strong>password@wineloversclub.com.au</strong></p>"
  else
  digested_password = BCrypt::Password.create(params["password"])
  create_new_user(params["name"], params["last"], params["email"], digested_password )
  redirect "/"
  end
end

get '/home' do
  wines = find_all_wines()
  erb :home, locals: { wines: wines }
end

delete '/session' do
  session["id"] = nil
  redirect '/'
end

get '/my_wine' do

  erb :my_wine
end

post "/new_wine" do
  create_new_wine(session["id"], params["title"], params["year"], params["image_url"], params["type"], params["score"], params["review"])
  redirect "/home"
end

get '/my_wine/:type' do
  user = session["id"]
  wine_type = params[:type]
  wines = find_all_wines_by_id_and_type(user, wine_type)
  erb :wine_detail, locals: { wines: wines, wine_type: wine_type }
end

get '/my_wine/:id/edit' do
  old_data = find_wine_by_id(params[:id])
  erb :edit, locals: { old_data: old_data }
end

put '/my_wine/:id/edit' do
  update_a_wine(params["id"], params["title"], params["year"], params["image_url"], params["type"], params["score"], params["review"])
  redirect "/my_wine/#{params['type']}"
end

get '/pairing' do
  erb :page_filer
end

get '/new_events' do
  erb :page_filler2
end