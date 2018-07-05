class Employee
  attr_accessor :id, :username, :password, :role

  def initialize(attributes = {})
    @username = attributes[:username] || ""
    @password = attributes[:password] || ""
    @role = attributes[:role]
    @id = attributes[:id]
  end

  def manager?
    role.downcase == "manager"
  end

  def delivery_guy?
    role.downcase == "delivery_guy"
  end
end
