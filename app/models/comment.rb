class Comment < ApplicationRecord
  belongs_to :advert
  validates :content, presence: true, length: { maximum: 140 }
end
