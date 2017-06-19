class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :stock
  validate :check_minimum_bid

  def check_minimum_bid
    return if bidding_price >= 100
    errors.add(:minimum_bid, ": Minimum bidding amount is RM100.")
  end

end
