class Item < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :bids, dependent: :destroy
  validate :check_negative_price
  validate :check_past_dates
  # mount_uploaders :images, ImageUploader
  searchkick match: :word_start, searchable: [:name, :brand, :model_number, :color]

  def check_negative_price
    return if resell_price || retail_price >= 1
    errors.add(:negative_price, "Price cannot be negative.")
  end

  def check_past_dates
    return if release_date == DateTime.now.to_date.past?
  end
end
