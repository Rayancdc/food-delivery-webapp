class Order
  attr_accessor :id, :meal, :employee, :customer, :delivered, :time

  def initialize(attributes = {})
    @meal = attributes[:meal] || ""
    @employee = attributes[:employee] || ""
    @customer = attributes[:customer]
    @id = attributes[:id]
    @delivered = attributes[:delivered] || false
    @time = attributes[:time] || Time.now.strftime("%d %b %Y, %H:%M")
  end

  def delivered?
    delivered
  end

  def deliver!
    @delivered = true
  end
end
