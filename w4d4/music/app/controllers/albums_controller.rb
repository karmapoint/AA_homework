class AlbumsController < ApplicationController
 before_action :require_user!
  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
      return
    else
      flash.now[:errors] = ['failed to add album']
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
      return
    else
      flash.now[:errors] = ['failed to update album']
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band_id)
  end

  private
  def album_params
    params.require(:album).permit(:name, :album_type, :band_id)
  end



end
