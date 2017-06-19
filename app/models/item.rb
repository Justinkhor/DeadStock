class Item < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :stocks, dependent: :destroy
  # mount_uploaders :images, ImageUploader
  searchkick match: :word_start, searchable: [:name, :brand, :model_number, :color]

  def num_of_sales
  end
end
