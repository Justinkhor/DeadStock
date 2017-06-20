class SneakersController < ApplicationController

  def index
    @user = User.new
    @item = Item.all



  # client = Instagram.client(:access_token => session[:access_token])
  # byebug
  # html = "<h1>Get a list of the overall most popular media items</h1>"
  # for media_item in client.media_popular
  #   html << "<img src='#{media_item.images.thumbnail.url}'>"
  # end
  # html

  end
end
