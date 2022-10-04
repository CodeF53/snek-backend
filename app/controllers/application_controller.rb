class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/leaderboard' do
    User.all.map(&:leaderboard_data).to_json
  end

  post '/login' do
    existing_user = User.where(username: params[:username])
    return { error: 'invalid username' }.to_json if existing_user.empty?
    return { error: 'invalid password' }.to_json unless existing_user[0].password == params[:password]

    return existing_user.to_json(only: [:username, :id, :session_cookie])
  end

  post '/signup' do
    existing_user = User.where(username: params[:username])
    return { error: 'username already taken' }.to_json unless existing_user.empty?

    user = User.create(username: params[:username], password: params[:password])
    user.initialize_session_cookie
    return user.to_json(only: [:username, :id, :session_cookie])
  end

  post '/play' do
    stated_user = User.where(id: params[:id])
    return { error: 'invalid user, user does not exist!' }.to_json unless stated_user.empty?
    return { error: 'invalid session cookie' }.to_json unless stated_user.session_cookie == params[:session_cookie]

    play = stated_user.new_play(playtime: params[:playtime], score: params[:score])
    return play.to_json
  end
end
