# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb

require_relative './app/models/customer.rb'
require_relative './app/models/employee.rb'
require_relative './app/models/meal.rb'
require_relative './app/models/order.rb'
require_relative './app/repositories/base_repository.rb'
require_relative './app/repositories/customer_repository.rb'
require_relative './app/repositories/employee_repository.rb'
require_relative './app/repositories/meal_repository.rb'
require_relative './app/repositories/order_repository.rb'
require_relative './app/controllers/base_controller.rb'
require_relative './app/controllers/customers_controller.rb'
require_relative './app/controllers/meals_controller.rb'
require_relative './app/controllers/orders_controller.rb'
require_relative './app/controllers/sessions_controller.rb'
require_relative './app/views/view.rb'
require_relative './app/views/session_view.rb'
require_relative './router.rb'
require 'csv'
require 'pry-byebug'

puts "Searching CSVS..."
meals_csv = File.join(__dir__, 'data/meals.csv')
employees_csv = File.join(__dir__, 'data/employees.csv')
customers_csv = File.join(__dir__, 'data/customers.csv')
orders_csv = File.join(__dir__, 'data/orders.csv')

puts "Loading Repositories..."
meal_repository = MealRepository.new(meals_csv)
employee_repository = EmployeeRepository.new(employees_csv)
customer_repository = CustomerRepository.new(customers_csv)
order_repository = OrderRepository.new(orders_csv, meal_repository, employee_repository, customer_repository)

puts "Loading Controllers..."
meals_controller = MealsController.new(meal_repository)
sessions_controller = SessionsController.new(employee_repository)
customers_controller = CustomersController.new(customer_repository)
orders_controller = OrdersController.new(meal_repository, employee_repository, customer_repository, order_repository)

puts "Loading Router..."
parameters = { meals: meals_controller,
               sessions: sessions_controller,
               customers: customers_controller,
               orders: orders_controller }
router = Router.new(parameters)

puts "Starting the Router..."
router.run
