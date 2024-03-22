require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product attributes" do
    product = Product.new(code: 'GR1', name: 'Green Tea', price: 3.11)
    assert_equal 'GR1', product.code
    assert_equal 'Green Tea', product.name
    assert_equal 3.11, product.price
  end
end