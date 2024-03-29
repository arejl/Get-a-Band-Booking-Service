class PicturesController < ApplicationController
  before_action :set_artist, only: [:create, :destroy]

  def create
    @artist.pictures.attach(params[:pictures] )   
    redirect_to artist_bookings_path(artist_id: @artist.id), success: "Image bien ajoutée"
  end 

  def destroy
    @picture = ActiveStorage::Attachment.find(params[:id])
    @picture.purge
    flash[:success] = "Image bien effacée"
    redirect_to artist_bookings_path(artist_id: @artist.id)
  end

  private
  def set_artist
    @artist = current_artist    
  end
end
