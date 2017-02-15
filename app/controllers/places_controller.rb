class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:place_city] = params[:city]
      render :index
    end
  end

  def show
    places_in_cache = Rails.cache.read(session[:place_city])
    @place_to_show = places_in_cache.find{|pl| pl.id == params[:id]}
  end
end
