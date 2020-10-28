class Advert < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :taggings
  has_many :tags, through: :taggings
  validate :photos_count_within_bounds
  has_many :comments, dependent: :destroy
  mount_uploader :picture, PictureUploader
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :content, presence: true, length: { minimum: 10, maximum: 3000 }
  belongs_to :user
  validates :user_id, presence: true
  validate :picture_size
  validates :address, presence: true, case_sensitive: false, length: { minimum: 10, maximum: 150 }
  validates :locality, length: { maximum: 25 }, allow_nil: true
  validates :administrative_area_level_1, length: { maximum: 35 }, allow_nil: true

  private

  # Validates the size of an uploaded picture.
  def picture_size
    errors.add(:picture, 'should be less than 10MB') if picture.size > 10.megabytes
  end

  def photos_count_within_bounds
    errors.add(:tags, 'no more than 6') if tags.size > 6
  end
end
