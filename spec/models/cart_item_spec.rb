require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart) { Cart.new }
  describe "Cart Item 基本功能" do
    it "每個 CartItem 可以計算自己的金額。" do
      p1 = create(:product, price: 100)
      p2 = create(:product, price: 50)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.items.first.total_price).to eq 300
      expect(cart.items.second.total_price).to eq 100
    end
  end
end
