class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :set_album
  before_action :set_user

  def index
    @images = Image.all
  end

  def new
    countOfImages = Image.where(:album_id => @album.id).count
    if countOfImages <= 25
      @image = @album.images.new
    else
      respond_to do |format|
        format.html {redirect_to root_path}
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def create
    @image = Image.create(image_params)
    @image.user_id = current_user.id
    @image.album_id = @album.id
    respond_to do |format|
      if @image.save!
        format.html { redirect_to album_images_path(@album), notice: "image created successfully" }
        format.json { render :show, status: :created, location: @image }
      else
        format.html {render :index}
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to album_images_path(@album), notice: 'image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to album_images_path(@album), notice: 'image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

    def set_user
      @user = current_user
    end

    def set_image
      @image = Image.find(params[:id])
    end

    def set_album
      @album = Album.find(params[:album_id])
    end

    def image_params
      params.require(:image).permit(:name, :tagline, :created_date,:owner, :album_id, :user_id, :image)
    end
end
