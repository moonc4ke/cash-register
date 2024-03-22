module Discount
  class BaseDiscount
    def self.apply(cart_items)
      raise NotImplementedError, "This #{self.class} cannot respond to:"
    end
  end

  class BogofGreenTea < BaseDiscount
    def self.apply(cart_items)
      green_teas = cart_items.select { |item| item.code == 'GR1' }
      return 0 if green_teas.empty?

      free_teas = green_teas.count / 2
      green_teas.first.price * free_teas
    end
  end

  class BulkStrawberries < BaseDiscount
    def self.apply(cart_items, discount_price: 4.50, required_quantity: 3)
      strawberries = cart_items.select { |item| item.code == 'SR1' }
      if strawberries.count >= required_quantity
        original_total = strawberries.sum(&:price)
        bulk_total = strawberries.count * discount_price
        discount_total = original_total - bulk_total
      else
        discount_total = 0
      end
      discount_total
    end
  end

  class CoffeeDiscount < BaseDiscount
    def self.apply(cart_items, discount_rate: 2.0 / 3.0, required_quantity: 3)
      coffees = cart_items.select { |item| item.code == 'CF1' }
      if coffees.count >= required_quantity
        original_price_per_coffee = coffees.first.price
        discounted_price_per_coffee = original_price_per_coffee * discount_rate
        discount_total = (original_price_per_coffee - discounted_price_per_coffee) * coffees.count
      else
        discount_total = 0
      end
      discount_total
    end
  end
end