class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @images =  Image.last(25)
  end
end
