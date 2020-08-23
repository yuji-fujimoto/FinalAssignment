class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :items, :dependent => :destroy
  has_many :outfits, :dependent => :destroy
  
  # accepts_nested_attributes_for :items
  # validate :items_size_vailidate
  
  # ITEM_MAX = current_user.max_tops
  # def item_size_validate
  #   errors.add(:items, "items over") if self.items.size > ITEM_MAX
  # end

  
end
