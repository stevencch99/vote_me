class Cart
  attr_reader :items
  def initialize(items = [])
    @items = items
  end
  
  def add_item(product_id)
    # check if itme already exist?
    # 這裡的 items 是一個方法，由 attr_reader :items 提供的
    found_item = items.find { |item| item.product_id == product_id }
    if found_item
      found_item.increment
    else
      items << CartItem.new(product_id)
    end
  end

  def empty?
    items.empty?
  end

  def total_price
    total = items.reduce(0) { |sum, item| sum + item.total_price }

    if xmas?
      total *= 0.9
    else
      total
    end
  end

  def serialize
    result = items.map { |item| { "product_id" => item.product_id, "quantity" => item.quantity} }
    { "items" => result }
  end

  def self.from_hash(hash)
    if hash && hash["items"]
      new hash["items"].map { |item| CartItem.new(item["product_id"], item["quantity"]) }
    else
      new
    end
  end

  private

  def xmas?
    Time.now.month == 12 && Time.now.day == 25
  end
end