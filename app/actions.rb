require 'sinatra'
configure do 
  enable :sessions 
end

helpers do
  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

# Homepage (Root path)
get '/' do
  redirect '/songs'
end

get '/songs' do 
  @songs = Song.all
  erb :'songs/index'
end


get '/songs/new' do 
  erb :'songs/new'
end

# get '/songs/users/signup' do 
#   erb :"songs/users/signup"
# end

get '/signup' do
  erb :'users/signup'
end

post '/signup' do
  user = User.new(
    username: params[:username],
    name: params[:name],
    email: params[:email],
    password: params[:password]
  )
  if user.save
    session[:user_id] = user.id
    redirect '/songs'
  else
    erb :'users/signup'
  end
end

post '/signin' do
  username = params[:username]
  password = params[:password]

  user = User.find_by(username: username, password: password)
  if user
    session[:user_id] = user.id
    redirect '/songs'
  else
    redirect '/songs'
  end
end

post '/logout' do
  session[:user_id] = nil
  redirect "/songs"
end

# def delete_cookie(name)
#   response.set_cookie(name, :value =>"", :path => "/", :expires => Time.now - 60*60*24*365*3)
# end

# get '/songs/users/signout' do 
#   delete_cookie ("username")
#   "expired"
#   redirect '/songs'
# end


post '/vote' do 
  @vote = Vote.new(
    user_id: current_user.id,
    song_id: params[:song_id]
    )
  if @vote.save 
     redirect '/songs'
  else
    @vote.errors.full_messages 
  end
end

post '/review' do 
  @review = Review.new(
    user_id: current_user.id,
    song_id: params[:song_id],
    content: params[:content]
    )
  if @review.save
    redirect "songs/#{params[:song_id]}"
  else
    @review.errors.full_messages
  end
end


get '/songs/:id' do 
  @song = Song.find params[:id]
  # @reviews = Song.reviews.each 
  erb :"songs/show"
end

get'/songs/show_others/:author' do 
  @songs = Song.where(author: params[:author])
  erb :"songs/show_others"
end

# post '/songs/users' do 
#   @user = User.new(
#     username: params[:username],
#     name: params[:name],
#     email: params[:email],
#     password: params[:password]
#     )
#   if @user.save 
#     redirect '/songs'
#   else
#     erb :'songs/users/signup'
#   end
# end

post '/songs' do 
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
    )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

