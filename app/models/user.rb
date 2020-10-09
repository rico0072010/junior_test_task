class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :adverts, dependent: :destroy
  validates :username, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :username
  validate :avatar_size

  private

  # Validates the size of an uploaded picture.
  def avatar_size
    errors.add(:avatar, 'should be less than 500KB') if avatar.size > 0.5.megabytes
  end
end
