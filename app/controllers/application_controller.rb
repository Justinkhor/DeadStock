class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def new
      @user = User.new  # = user_from_params
      # render template: "users/new"
  end
end
