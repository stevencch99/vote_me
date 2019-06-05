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
      p1 = create(:product)
      p2 = create(:product)

      2.times { cart.add_item(p1.id) }
      3.times { cart.add_item(p2.id) }

      expect(cart.items.first.product).to be_a Product
      expect(cart.items.first.product.title).to eq p1.title
    end

    it "可以計算整台購物車的總消費金額。" do
      p1 = create(:product, price: 100)
      p2 = create(:product, price: 50)

      2.times { cart.add_item(p1.id) }
      3.times { cart.add_item(p2.id) }

      expect(cart.total_price).to eq 350
    end

    it "聖誕節的時候全面打 9 折。" do
      t = Time.local(2020, 12, 25, 10, 5, 0)
      Timecop.travel(t)

      p1 = create(:product, price: 100)
      p2 = create(:product, price: 50)

      2.times { cart.add_item(p1.id) }
      3.times { cart.add_item(p2.id) }

      expect(cart.total_price).to eq 315
    end
  end

  describe '進階功能' do
    it "可以將購物車內容轉換成 Hash 並存到 Session 裡。" do
      p1 = create(:product)
      p2 = create(:product)

      3.times { cart.add_item(p1.id) }
      5.times { cart.add_item(p2.id) }

      expect(cart.serialize).to eq session_hash
    end

    it "可以將存放在 Session 的內容(Hash 格式) 還原成購物車內容。" do
      cart = Cart.from_hash(session_hash)

      expect(cart.items.first.quantity).to eq 3
      expect(cart.items.last.product_id).to eq 2
    end
  end

  private

  def session_hash
    # 網路傳送的過程中 symble 會變成字串，故這邊採用舊式寫法
    {
      "items" => [
        { "product_id" => 1, "quantity" => 3 },
        { "product_id" => 2, "quantity" => 5 }
      ]
    }
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