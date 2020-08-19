class Outfit < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :concept, length: { maximum: 255 }
end
