class BidsController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy]


	def index
		@bids = current_user.bids
	end

	def show

	end

  def edit

  end

  def new
    @item = Item.find(params[:item_id])
    @stock = @item.stocks.order('resell_price DESC').last
    @bid = Bid.new
  end

  def create
    @item = Item.find(params[:item_id])
    @stock = @item.stocks.order('resell_price DESC').last
		@bid = current_user.bids.new(bid_params)
    @bid.stock_id = @stock.id
    # @bid.item = @item
    byebug
    if @bid.save
      # @host = User.find(@item.user_id)
      #     # BidMailer.bid_email(current_user, @host, @bid.item.id, @bid.id).deliver_later
      #     BidJob.perform_later(current_user, @host, @bid.item.id, @bid.id)
  		redirect_to new_bid_braintree_path(@bid) , notice: "Your bid has been created, please make payment to confirm the bid."
    else
      @errors = @bid.errors.full_messages
      render "items/show"
    end
	end

  def update
  end

  def destroy
    @bid = Bid.find(params[:id])
    @bid.destroy
    redirect_to @bid.user
  end

  private
		def bid_params
			params.require(:bid).permit(:bidding_price, :gender, :size, :closing_date, :stock_id, :user_id)
		end

end
