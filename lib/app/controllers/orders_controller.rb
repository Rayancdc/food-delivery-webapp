require_relative '../repositories/order_repository.rb'

class OrdersController
  attr_accessor :meal_repository, :employee_repository, :customer_repository, :order_repository
  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @view = View.new
  end

  # def create_object
  #   meal = @view.ask_name
  #   employee = @view.ask_price
  #   Meal.new(name: name, price: price)
  # end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @view.display_orders(undelivered_orders)
  end

  def add
    attributes = {}
    @view.display_meals(@meal_repository.all)
    attributes[:meal] = @meal_repository.find(@view.ask_meal_id)
    @view.display_customers(@customer_repository.all)
    attributes[:customer] = @customer_repository.find(@view.ask_customer_id)
    @view.display_employees(@employee_repository.all)
    attributes[:employee] = @employee_repository.find(@view.ask_employee_id)
    order = Order.new(attributes)
    @order_repository.add(order)
  end

  # Customer

  def list_customer_orders(customer)
    my_orders = @order_repository.user_orders(customer)
    @view.display_to_customer(my_orders)
  end

  def place_order(customer)
    attributes = {}
    @view.display_meals(@meal_repository.all)
    attributes[:meal] = @meal_repository.find(@view.ask_meal_id_customer)
    attributes[:customer] = customer
    attributes[:employee] = @employee_repository.all_delivery_guys.sample
    order = Order.new(attributes)
    @order_repository.add(order) if order
  end

  # Delivery guy

  def list_my_orders(employee)
    my_orders = @order_repository.undelivered_orders.select { |order| employee.username == order.employee.username }
    @view.display_orders(my_orders)
  end

  def mark_as_delivered(employee)
    id = @view.ask_order_id
    my_order = @order_repository.undelivered_orders.find { |order| order.id == id }
    my_order.deliver!
    @order_repository.update_csv
  end
end
