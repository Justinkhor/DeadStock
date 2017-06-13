class StaticController < ApplicationController
  def index
    # unless signed_in?
    #   redirect_to sign_in_path
    # end
    @items = Item.all.order('created_at DESC').paginate(:page => params[:page]).per_page(20)
  end
end
