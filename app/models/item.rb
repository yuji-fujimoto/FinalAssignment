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
  
  # validate :user_items_size_validate
  # def user_items_size_validate
  #   if self.user && self.user.items.size >= User::ITEM_MAX
  #     errors.add(:base, "itemsはこれ以上登録できません")
  #   end
  # end
  
end
