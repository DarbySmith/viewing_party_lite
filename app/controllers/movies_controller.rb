class MoviesController < ApplicationController
  def index
    @user = User.find(session[:user_id])

    if params[:top_movies]
      @movies = MovieFacade.top_movies
    elsif params[:search]
      @movies = MovieFacade.search_movie(params[:search])
    end
  end

  def show
    @reviews = MovieFacade.movie_reviews(params[:id])
    @cast = MovieFacade.movie_cast(params[:id]).take(10)
    @movie_details = MovieFacade.movie_details(params[:id])
  end
end