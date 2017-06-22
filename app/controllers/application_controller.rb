class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def new
      @user = User.new  # = user_from_params
      @item = Item.all
      # render template: "users/new"
  end
end
