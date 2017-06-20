class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :stock
  validate :check_chosen_bid

  def check_chosen_bid
    return if self.chosen_bid == false
    errors.add(:chosen_bid, "You are the highest bidder, stop trying!")
  end
end
