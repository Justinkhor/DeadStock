class Item < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :bids, dependent: :destroy
  # mount_uploaders :images, ImageUploader
  searchkick match: :word_start, searchable: [:country, :state, :city, :zipcode, :address, :description]
end
