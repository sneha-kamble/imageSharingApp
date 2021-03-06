class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Album.all
  end

  def new
    @album = Album.new
  end

  def edit
  end

  def create
    @album = Album.create(album_params)
    @album.user_id = current_user.id
    respond_to do |format|
      if @album.save!
        format.html { redirect_to albums_path, notice: "album created successfully" }
        format.json { render :show, status: :created, location: @album }
      else
        format.html {render :index}
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to albums_path, notice: 'album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_path, notice: 'album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:name,:created_date,:owner, :user_id)
    end
end
