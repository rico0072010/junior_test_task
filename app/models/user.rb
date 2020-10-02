class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :adverts, dependent: :destroy
  validates :username, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :username
end
