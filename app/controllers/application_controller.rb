
  class ApplicationController < Sinatra::Base
    set :default_content_type, 'application/json'
    # Add your routes here
    get "/" do
      "let's start"
    end
    def login_error
      @message = {error: "Invalid username or password"}
      return @message.to_json
    end
    # create a user account with username, password and email
    post '/newuser' do
      new_user = User.create(
        username: params[:username],
        email: params[:email],
        password: params[:password]
      )
      new_user.to_json
    end
    # login user using an email and a password
    post '/login' do
      password = params[:password]
      logging_user = User.find_by(email: params[:email])
      if (logging_user)
        if (logging_user.password == password)
          return logging_user.to_json
        else
          login_error
        end
      else
        login_error
      end
    end
    # create a new movie
    post '/newmovie/:id' do
      movie = User.find(params[:id]).movies.create(
        title: params[:title],
        genre: params[:genre],
        year: params[:year],
        rating: params[:rating],
      )
      movie.to_json
    end
    # get a given users movies
    get '/movies/:user_id' do
      user = params[:user_id].to_i
      movies = Movie.where(user_id: user)
      movies.to_json
    end
    # view all movies
    get '/movies' do
      movies = Movie.all.to_json
    end
    # view all users
    get '/users' do
      users = User.all.to_json
    end
    get '/user/:id' do
      user = User.find(params[:id])
      user.to_json(include: :movies)
    end
    # search for a given movie
    get '/search/:term' do
      term = params[:term]
      movie = Movie.where(year: term.to_i) ||  Movie.find_by(title: term)
      if movie
        return movie.to_json
      else
        error_message = {error: "Could not find movie that matches search term"}
        return error_message.to_json
      end
    end
     # update a movie's details
    patch '/edit/:id/:id2' do
      data = JSON.parse(request.body.read)
      movie = User.find(params[:id]).movies
      movie.find(params[:id2]).update(data)
      movie.to_json
    end
    # delete a movie from the site
    delete '/delete/:id/:id2' do
      movie = User.find(params[:id]).movies.find(params[:id2])
      movie.destroy
    end
  end

