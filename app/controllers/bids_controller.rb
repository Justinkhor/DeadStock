class BidsController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy]


	def index
    @bids = Bid.all.order('created_at DESC').paginate(:page => params[:page]).per_page(20)
	end

	def show

	end

  def edit

  end

  def new
    @user = current_user
    @item = Item.find(params[:item_id])
    @stock = Stock.find(params[:stock_id])
    @stocks = @item.stocks.where(sold: false).select(:size).order('resell_price DESC')
    @bid = Bid.new
  end

  def create
    @item = Item.find(params[:item_id])
    @stock = Stock.find(params[:stock_id])
		@bid = current_user.bids.new(bid_params)
    @bid.stock_id = @stock.id
    # @bid.item = @item
    if params[:buy]
      if @bid.save(context: :buy_process)
        @bid.chosen_bid = false
        @bid.bought = true
        @bid.save
        @stock.sold = true
        @stock.save
        # @host = User.find(@item.user_id)
        #     # BidMailer.bid_email(current_user, @host, @bid.item.id, @bid.id).deliver_later
        #     BidJob.perform_later(current_user, @host, @bid.item.id, @bid.id)
    		redirect_to new_bid_braintree_path(@bid) , notice: "Please make payment to secure your item."
      else
        redirect_to item_path(@item), notice: "Failed to buy."
      end
    else
      if (params[:bid][:bidding_price]).to_i < 100
         redirect_to item_path(@item), notice: "Minimum bid is RM100."
      elsif (params[:bid][:bidding_price]).to_i <= highest_bid
         redirect_to item_path(@item), notice: "Please make a higher bid."
      elsif (params[:bid][:bidding_price]).to_i >= lowest_ask
         redirect_to item_path(@item), notice: "Might as well buy now?"
      else
        expired_bid
         @bid.save
         redirect_to item_path(@item), notice: "Congratulations on being the highest bidder at the moment!"
      end
    end
	end

  def update
  end

  def destroy
    @bid = Bid.find(params[:id])
    @bid.destroy
    @stock.sold = false
    @stock.save
    redirect_to @bid.user
  end

  def highest_bid
    if !@stock.bids.empty?
      @stock.bids.order('bidding_price ASC').last.bidding_price
    else
      highest_bid = 99
    end
  end

  def lowest_ask
    @stock.resell_price
  end

  def expired_bid
    bid = @stock.bids.order('bidding_price ASC').last
      if bid != nil
        bid.chosen_bid = false
        bid.save
        # BidMailer.bid_email(current_user, @host, @bid.item.id, @bid.id).deliver_later
        BidJob.perform_later(bid.user_id, @item.id)
      end
  end

  def winner
    if @stock.closing_date < Date.today
      bid = @stock.bids.find_by(chosen_bid: true)
      WinningbidJob.perform_later(bid.user_id, bid.id)
    end
  end

  private
		def bid_params
			params.require(:bid).permit(:bidding_price, :gender, :size, :chosen_bid, :payment_made, :bought, :stock_id, :user_id)
		end

end
