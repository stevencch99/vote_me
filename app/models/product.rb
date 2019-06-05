class Product < ApplicationRecord
  # 加入 act_as_paranoid 類似 default_scope
  acts_as_paranoid
  # default_scope { where.not(delete_at: nil) }
  
  # validations
  validates :title, presence: true
  
  # scope
  scope :available, -> { where(is_available: true) }
  scope :expensive_product, -> { price_over(50) }
  scope :good_product, -> { available.expensive_product }
  scope :price_over, -> (n) { where("price >= #{n}") }

  # def self.available
  #   where(is_available: true).where("price >= 50")
  # end
end
