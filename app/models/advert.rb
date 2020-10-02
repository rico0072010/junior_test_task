class Advert < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  validates :content, presence: true, length: { minimum: 25, length: 1000 }
  belongs_to :user, foreign_key: 'user_id'
  validates :user_id, presence: true
  mount_uploader :picture, PictureUploader
  validate :picture_size
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy

  private

  # Validates the size of an uploaded picture.
  def picture_size
    :errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
  end
end
