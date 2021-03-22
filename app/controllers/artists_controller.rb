class ArtistsController < ApplicationController
  before_action :authenticate_artist!, except: [:index, :show]
  before_action :set_artist, only: [:show, :edit, :update]

  def index
    if index_params[:start_date].present?
      @start_at = index_params[:start_date]
      @end_at = @start_at.to_date + 1.day
      @artists = Availability.available_artists(@start_at, @end_at)
    else
      @artists = Artist.approved
      @start_at = Date.current
    end
  end

  def show
  end

  def create
  end

  def update
    if update_params[:categories].present?
      update_params[:categories].each do |category|
        ArtistCategory.create!(category_id: category.to_i, artist: @artist)
      end
    end

    if @artist.update!(update_params.except(:categories))
      redirect_to artist_bookings_path(artist_id: @artist.id)
      flash[:success] = "Vos informations ont bien été changées."
    else
      flash[:danger] = "Erreur: " + @artist.errors.full_messages.join(" ")
      render :edit
    end
  end

  def destroy
  end

  def edit
    @all_locations = Location.all
    @all_categories = Category.all
  end

  private

  def set_artist
    # params.permit(:id)
    @artist = current_artist
  end

  def index_params
    params.permit(:start_date)
  end

  def update_params
    params.require(:artist).permit(:artist_name, :description, :hourly_price, :location_id, :avatar, pictures: [], categories: [])
  end
end
