class Advert < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy
  mount_uploader :picture, PictureUploader
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  validates :content, presence: true, length: { minimum: 10, maximum: 1000 }
  belongs_to :user, foreign_key: 'user_id'
  validates :user_id, presence: true
  validate :picture_size

  private

  # Validates the size of an uploaded picture.
  def picture_size
    errors.add(:picture, 'should be less than 10MB') if picture.size > 10.megabytes
  end
end
