require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it "每個 Cart Item 都可以計算它自己的金額（小計）" do
    cart = Cart.new

    p1 = Product.create(title: "牛肉麵", price: 70)
    p2 = Product.create(title: "牛肉湯麵", price: 80)

    3.times{ cart.add_item(p1.id) }
    4.times{ cart.add_item(p2.id) }
    2.times{ cart.add_item(p1.id) }

    expect(cart.items.first.total_price).to be 350
    expect(cart.items.second.total_price).to be 320
  end

  it "可以計算整台購物車的總消費金額" do
    cart = Cart.new

    p1 = Product.create(title: "牛肉麵", price: 70)
    p2 = Product.create(title: "牛肉湯麵", price: 80)

    3.times{ cart.add_item(p1.id) }
    4.times{ cart.add_item(p2.id) }
    2.times{ cart.add_item(p1.id) }

    expect(cart.total_price).to be 670
  end

  it "特別活動可能可搭配折扣（例如聖誕節的時候全面打 9 折，或是滿額滿千送百）" do
    cart = Cart.new

    p1 = Product.create(title: "牛肉麵", price: 70)
    p2 = Product.create(title: "牛肉湯麵", price: 80)

    3.times{ cart.add_item(p1.id) }
    4.times{ cart.add_item(p2.id) }
    7.times{ cart.add_item(p1.id) }

    expect(cart.total_price).to be 920
  end
end
