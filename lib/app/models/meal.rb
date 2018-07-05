class Meal
  attr_accessor :name, :price, :id

  def initialize(attributes = {})
    @name = attributes[:name] || ""
    @price = attributes[:price] || 0
    @id = attributes[:id]
  end
end
