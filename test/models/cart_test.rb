require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    @green_tea = Product.new(code: 'GR1', name: 'Green Tea', price: 3.11)
    @strawberries = Product.new(code: 'SR1', name: 'Strawberries', price: 5.00)
    @coffee = Product.new(code: 'CF1', name: 'Coffee', price: 11.23)
    @cart = Cart.new(DEFAULT_DISCOUNTS)
  end

  test "should add products to the cart" do
    @cart.add(@green_tea)
    @cart.add(@strawberries)
    assert_equal 2, @cart.items.count
    assert_includes @cart.items, @green_tea
    assert_includes @cart.items, @strawberries
  end

  test "should calculate total price without discounts" do
    @cart.add(@green_tea)
    @cart.add(@strawberries)
    expected_total = @green_tea.price + @strawberries.price
    assert_equal expected_total, @cart.total
  end

  test "should apply BOGO Green Tea discount correctly" do
    2.times { @cart.add(@green_tea) }
    expected_total = @green_tea.price
    assert_equal expected_total, @cart.total
  end

  test "should apply bulk Strawberries discount correctly" do
    3.times { @cart.add(@strawberries) }
    expected_total = 4.50 * 3
    assert_equal expected_total, @cart.total
  end

  test "should apply Coffee discount correctly for 3 or more" do
    3.times { @cart.add(@coffee) }
    discounted_price_per_coffee = @coffee.price * (2.0 / 3.0)
    expected_total = discounted_price_per_coffee * 3
    assert_in_delta expected_total, @cart.total, 0.01
  end
end
