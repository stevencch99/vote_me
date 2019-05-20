class Candidate < ApplicationRecord
  # 驗證器
  validates :name, presence: true
end
