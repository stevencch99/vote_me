class Candidate < ApplicationRecord
  # 驗證器
  validates :name, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 40 }
end
