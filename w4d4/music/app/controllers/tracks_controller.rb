class TracksController < ApplicationController

  before_action :require_user!
   def new
     @track = Track.new
     render :new
   end

   def create
     @track = Track.new(track_params)
     if @track.save
       redirect_to track_url(@track)
       return
     else
       flash.now[:errors] = ['failed to add track']
       render :new
     end
   end

   def show
     @track = Track.find(params[:id])
     render :show
   end

   def edit
     @track = Track.find(params[:id])
     render :edit
   end

   def update
     @track = Track.find(params[:id])
     if @track.update(track_params)
       redirect_to track_url(@track)
       return
     else
       flash.now[:errors] = ['failed to update track']
       render :edit
     end
   end

   def destroy
     @track = Track.find(params[:id])
     @track.destroy
     redirect_to album_url(@track.album_id)
   end

   private
   def track_params
     params.require(:track).permit(:song, :track_type, :album_id, :lyrics)
   end


end
