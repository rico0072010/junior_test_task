class Tag < ApplicationRecord
  has_many :taggings
  has_many :adverts, through: :taggings
  validates :name, presence: true, length: { minimum: 2, maximum: 15 }
  validates_uniqueness_of :name
end
