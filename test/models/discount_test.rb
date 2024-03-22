require 'test_helper'

class DiscountTest < ActiveSupport::TestCase
  setup do
    @green_tea = Product.new(code: 'GR1', name: 'Green Tea', price: 3.11)
    @strawberries = Product.new(code: 'SR1', name: 'Strawberries', price: 5.00)
    @coffee = Product.new(code: 'CF1', name: 'Coffee', price: 11.23)
  end

  test "BogofGreenTea discount applies correctly" do
    items = [@green_tea, @green_tea]
    discount_amount = Discount::BogofGreenTea.apply(items)
    assert_equal 3.11, discount_amount, "Buy one get one free discount on Green Tea did not apply correctly"
  end

  test "BulkStrawberries discount applies correctly" do
    items = 3.times.map { @strawberries }
    discount_amount = Discount::BulkStrawberries.apply(items)
    original_price_per_strawberry = 5.00
    bulk_price_per_strawberry = 4.50
    number_of_strawberries = items.count
    expected_discount = (original_price_per_strawberry - bulk_price_per_strawberry) * number_of_strawberries
    assert_equal expected_discount, discount_amount, "Bulk discount on Strawberries did not apply correctly"
  end

  test "CoffeeDiscount applies correctly for 3 or more coffees" do
    items = 3.times.map { @coffee }
    discount_amount = Discount::CoffeeDiscount.apply(items)
    expected_discount = 3 * 11.23 - (3 * (11.23 * 2 / 3))
    assert_in_delta expected_discount, discount_amount, 0.01, "Discount on Coffee did not apply correctly"
  end

  test "CoffeeDiscount does not apply for less than 3 coffees" do
    items = 2.times.map { @coffee }
    discount_amount = Discount::CoffeeDiscount.apply(items)
    assert_equal 0, discount_amount, "Discount on Coffee incorrectly applied for less than 3 items"
  end
end
