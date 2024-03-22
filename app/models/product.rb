class Product
  attr_reader :code, :name, :price

  def initialize(code:, name:, price:)
    raise ArgumentError, 'Code and name cannot be empty' if code.empty? || name.empty?
    raise ArgumentError, 'Price must be a positive number' unless price.positive?
    
    @code = code
    @name = name
    @price = price
  end
end