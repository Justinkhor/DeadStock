class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validate :check_overlapping_dates, on: :create
  validate :check_max_guests
  validate :check_negative_guests
  validate :check_past_dates

  def check_overlapping_dates
    item.bids.each do |existing_bids|
      if overlap?(self, existing_bids)
        return errors.add(:overlapping_dates, ":The bid dates are not available.")
      end
    end
  end

  def overlap?(x,y)
    (x.check_in - y.check_out) * (y.check_in - x.check_out) > 0
  end

  def check_max_guests
    max_guests = item.guest_number
    return if num_of_guests <= max_guests
    errors.add(:max_guests, ": Maximum number of guests exceeded.")
  end

  def check_negative_guests
    return if num_of_guests >= 1
    errors.add(:negative_guests, "There must be at least 1 guest.")
  end

  def check_past_dates
    return if check_in == DateTime.now.to_date.past?
  end

  def total_price
    price = item.price_per_night
    num_dates = (check_in..check_out).to_a.length
    return price * (num_dates - 1)
  end

end
