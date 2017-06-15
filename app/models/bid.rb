class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validate :check_min_bid

  def check_min_bid
    return if bidding_price >= 100
    errors.add(:min_bid, ": Minimum bidding amount is RM100.")
  end
end
