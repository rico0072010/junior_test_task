class Tag < ApplicationRecord
  has_many :taggings
  has_many :adverts, through: :taggings
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
end
