class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :stock
  validate :check_minimum_bid

  def check_minimum_bid
    return if bidding_price >= 100
    errors.add(:minimum_bid, ": Minimum bidding amount is RM100.")
  end


  def bid
   if current_user == Stock.find(params[:stock_id]).user
     flash[:error] = "Can't place bid on your own item."
   elsif Stock.find(params[:stock_id]).bids.all(:order => "amount DESC").empty?
     if params[:bidding_price].to_f <= Stock.find(params[:stock_id]).resell_price
       flash[:error] = "Need to place bid higher than the opening bid"
     else
       Bid.create!(:user_id => current_user.id, :stock_id => params[:stock_id], :amount => params[:bidding_price])
     end
   elsif Stock.find(params[:stock_id]).bids.all(:order => "amount DESC").first.amount >= params[:bidding_price].to_f
     flash[:error] = "Your bid needs to be greater than highest bid"
   else
     Bid.create!(:user_id => current_user.id, :stock_id => params[:stock_id], :amount => params[:bidding_price])
   end
 end

end
