class Customer
  attr_accessor :name, :address, :id

  def initialize(attributes = {})
    @name = attributes[:name] || ""
    @address = attributes[:address] || ""
    @id = attributes[:id]
  end
end
