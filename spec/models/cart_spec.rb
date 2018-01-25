require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "購物車基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      cart = Cart.new
      cart.add_item(1)
      expect(cart.empty?).to be false
    end

    it "如果加了相同種類的商品到購物車裡，購買項目（CartItem）並不會增加，但商品的數量會改變" do
      cart = Cart.new

      3.times{ cart.add_item(1) }
      2.times{ cart.add_item(2) }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.last.product_id).to be 2
    end

    it "商品可以放到購物車裡，也可以再拿出來" do
      cart = Cart.new

      p1 = Product.create(title: "哈特利", price: 100)
      p2 = Product.create(title: "煙卷", price: 200)
      3.times{ cart.add_item(p1.id) }
      2.times{ cart.add_item(p2.id) }

      expect(cart.items.first.product).to be_a Product
      expect(cart.items.last.product_id).to be p2.id
    end

  end

  describe "購物車進階功能" do
    it "可以將購物車內容轉換成 Hash 並存到 Session 裡" do
      cart = Cart.new
      3.times { cart.add_item 1 }
      2.times { cart.add_item 2 }

      expect(cart.serialize).to eq cart_hash
    end

    it "Hash還原成購物車的內容" do
      cart = Cart.from_hash(cart_hash)

      expect(cart.items.count).to be 2
      expect(cart.items.first.product_id).to be 1
    end
  end

  private
  def cart_hash
    {
      "items" => [
        {"product_id" => 1, "quantity" => 3},
        {"product_id" => 2, "quantity" => 2}
       ]
    }
  end
end
