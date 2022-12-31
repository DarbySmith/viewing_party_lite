class ViewingPartiesController < ApplicationController
  before_action :require_login, only: [:new]
  
  def new
    @movie = MovieFacade.movie_details(params[:movie_id])
    @user = User.find(session[:user_id])
    @users = User.all
  end

  def create
    user = User.find(session[:user_id])
    party = Party.new(viewing_party_params)
    
    if party.save
      user_party = UserParty.create!(user: user, party: party, host: true)
      attendees = User.find(params[:attendees])
      attendees.each do |attendee|
        UserParty.create!(user: attendee, party: party, host: false)
      end
      redirect_to dashboard_path
    else
      flash[:alert] = party.errors.full_messages.to_sentence
      redirect_to new_movie_viewing_party_path(params[:movie_id])
    end
  end

  private
  def viewing_party_params
    params.permit(:duration, :day, :start_time, :movie_title)
  end

  def require_login
    if current_user.nil?
      movie = MovieFacade.movie_details(params[:movie_id])
      redirect_to movie_path(movie.id) 
      flash[:alert] = "User must be logged in or registered to access"
    end
  end
end