class Item < ApplicationRecord
  belongs_to :user
  
  validates :item_name, presence: true, length: { maximum: 255 }
  validates :category, presence: true
  validates :brand, length: { maximum: 255 }
  validates :size, length: { maximum: 255 }
  validates :purchase_price, length: { maximum: 255 }
  validates :remarks, length: { maximum: 255 }
  validates :color, length: { maximum: 255 }
  
  enum category: { tops: 1, outer: 2, pants: 3, bag: 4, shoes: 5 }
end
