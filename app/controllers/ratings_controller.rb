class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @top_beers = Beer.top 3
    @top_breweries = Brewery.top 3
    @top_styles = Style.top 3
    @top_users = User.top 3

    @latest_ratings = Rating.recent_five;
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if current_user.nil?
      redirect_to signin_path, notice:'You must sign in before rating a beer'
    elsif @rating.save
      current_user.ratings << @rating
      redirect_to user_path(current_user)
    else
     @beers = Beer.all
     render :new
  end
end

  def destroy
    rating = Rating.find_by id: params[:id]
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end
