     
require 'sinatra'
require 'sinatra/reloader'
require_relative "methods/user.rb"
require 'pg'
require 'bcrypt'
enable :sessions

get '/' do
  erb :login
end

post '/session' do
  user = find_user_by_email(params["email"])
  if user && BCrypt::Password.new(user["password_digest"]) == params["password"]
  session["name"] = user["name"]
  redirect '/home'
  else
    redirect '/'
  end
end

get '/signin' do
  erb :signin
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
  session['name']
end

delete '/session' do
  session["name"] = nil
  redirect '/'
end






