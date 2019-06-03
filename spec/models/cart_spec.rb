require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.new }
  describe '基本功能' do
    it "可以新增商品" do
      cart.add_item 1
      expect(cart.empty?).to be false
    end
    it "新增同樣的商品(CartItem)只會更新數量。" do
      3.times { cart.add_item 1 }
      2.times { cart.add_item 2 }
      3.times { cart.add_item 1 }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 6
    end
    it "商品可以放進購物車，也可以再拿出來。" do
      
    end
    # it "每個 CartItem 可以計算自己的金額。" do
    # end
    # it "可以計算整台購物車的總消費金額。" do
    # end
    # it "特別活動可搭配折扣(例如聖誕節的時候全面打 9 折，或是滿額滿千送百或滿額免運)。" do
    # end

  end
  describe '進階功能' do
  end
end

# - 基本功能
#   - 可以新增商品。
#   - 新增同樣的商品(CartItem)只會更新數量。
#   - 商品可以放進購物車，也可以再拿出來。
#   - 每個 CartItem 可以計算自己的金額。
#   - 可以計算整台購物車的總消費金額。
#   - 特別活動可搭配折扣(例如聖誕節的時候全面打 9 折，或是滿額滿千送百或滿額免運)。
# - 進階功能
#   - 可以將購物車內容轉換成 Hash 並存到 Session 裡。
#   - 也可以將存放在 Session 的內容(Hash 格式) 還原成購物車內容。