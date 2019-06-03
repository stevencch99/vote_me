class Cart
  attr_reader :items
  def initialize
    @items = []
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
end