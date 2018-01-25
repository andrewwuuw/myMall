class Cart
  attr_reader :items
  def initialize(items= [])
    @items = items
  end

  def self.from_hash(hash)
    if hash && hash["items"]
      new hash["items"].map { |item|
        CartItem.new(item["product_id"], item["quantity"])
      }
    else
      new
    end
  end

  def add_item(product_id)
    found_item = @items.find{ |item| item.product_id == product_id }

    if found_item
      found_item.increment
    else
      @items << CartItem.new(product_id)
    end
  end

  def serialize
    {
      all_items = items.map { |item|
        {"product_id" => item.product_id,
        "quantity" => item.quantity}
    }

    { "items" => all_items }
  end

  def empty?
    @items.empty?
  end

  def total_price
    total = items.reduce(0) { |sum, item| sum + item.total_price }
    if total > 1000
      total - 100
    else
      total
    end
  end
end
