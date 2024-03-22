class Cart
  attr_reader :items, :discounts

  def initialize(discount_strategies)
    @items = []
    @discounts = discount_strategies
  end

  def add(product)
    @items << product
  end

  def total
    total_price = items.sum(&:price)
    discounts.each do |discount|
      total_price -= discount.apply(items)
    end
    total_price
  end
end
