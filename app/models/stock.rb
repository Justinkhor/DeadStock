class Stock < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :bids, dependent: :destroy
  validate :check_negative_price

  def check_negative_price
    return if resell_price || retail_price >= 1
    errors.add(:negative_price, "Price cannot be negative.")
  end

end
