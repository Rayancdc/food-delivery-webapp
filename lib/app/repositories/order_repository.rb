require_relative 'base_repository'
require_relative 'meal_repository'
require_relative 'employee_repository'
require_relative 'customer_repository'
require_relative '../models/order.rb'
require 'pry-byebug'
class OrderRepository < BaseRepository
  attr_accessor :meal_repository, :employee_repository, :customer_repository
  def initialize(csv_filepath, meal_repository, employee_repository, customer_repository)
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    super(csv_filepath)
  end

  def user_orders(customer)
    @elements.select { |order| order.customer == customer }
  end

  def undelivered_orders
    @elements.reject { |order| order.delivered? }
  end

  def create_object(row)
    object = {}
    object[:id] = row[:id].to_i
    object[:meal] = @meal_repository.find(row[:meal_id].to_i)
    object[:employee] = @employee_repository.find(row[:employee_id].to_i)
    object[:customer] = @customer_repository.find(row[:customer_id].to_i)
    object[:delivered] = row[:delivered] == "true"
    Order.new(object)
  end

  def update_csv
    CSV.open(@csv_filepath, "wb", CSV_OPTIONS) do |csv|
      csv << ["id", "delivered", "meal_id", "employee_id", "customer_id", "time"]
      @elements.each do |order|
        csv << [order.id, order.delivered, order.meal.id, order.employee.id, order.customer.id, order.time]
      end
    end
  end
end
