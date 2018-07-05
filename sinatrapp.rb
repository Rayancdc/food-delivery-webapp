require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require 'csv'
require "better_errors"
require_relative './lib/app/models/customer.rb'
require_relative './lib/app/models/employee.rb'
require_relative './lib/app/models/meal.rb'
require_relative './lib/app/models/order.rb'
require_relative './lib/app/repositories/base_repository.rb'
require_relative './lib/app/repositories/customer_repository.rb'
require_relative './lib/app/repositories/employee_repository.rb'
require_relative './lib/app/repositories/meal_repository.rb'
require_relative './lib/app/repositories/order_repository.rb'
require_relative './lib/app/controllers/base_controller.rb'
require_relative './lib/app/controllers/customers_controller.rb'
require_relative './lib/app/controllers/meals_controller.rb'
require_relative './lib/app/controllers/orders_controller.rb'
require_relative './lib/app/controllers/sessions_controller.rb'
require_relative './lib/app/views/view.rb'
require_relative './lib/app/views/session_view.rb'
require_relative './lib/router.rb'

puts "Searching CSVS..."
meals_csv = File.join(__dir__, './lib/data/meals.csv')
employees_csv = File.join(__dir__, './lib/data/employees.csv')
customers_csv = File.join(__dir__, './lib/data/customers.csv')
orders_csv = File.join(__dir__, './lib/data/orders.csv')

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


set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

# Sinatra application commands!! GETS POSTS AND OTHER COOL STUFF

get '/' do
  erb :index
end

get '/login' do
  erb :login
end

get '/login/:username' do
  @user = sessions_controller.sign_in(params)
  case @user.role
  when "manager"
    erb :manager
  when "delivery_guy"
    erb :delivery
  else
    erb :about
  end
end

get '/meals/list' do
  erb :new
end

get '/meals/create' do
  erb :new
end

get '/meals/delete' do
  erb :new
end

post '/login' do
  @user = sessions_controller.sign_in(params)
  if @user && params["password"] == @user.password
    redirect "/login/#{@user.username}"
  else
    redirect "/login"
  end
end

  # recipe = controller.create(params)
  # redirect "/recipe/#{recipe.id}"
  # instancia a nova receita
  # atualiza o csv

# # Open exec bundle ruby sinatrapp.rb em um terminal
# # Depois executa ~/Downloads/ngrok http 4567 em outro terminal
# As specified in the documentation, you may use sessions or convert the POST params to a query string and use it in the redirect method. A crude example would be:

# Say the POST params hash inside the '/' block is:

# {
#   :name => "Whatever",
#   :address => "Wherever"
# }

# This hash can be made into a string like so:

# query = params.map{|key, value| "#{key}=#{value}"}.join("&")
# # The "query" string now is: "name=Whatever&address=Wherever"

# Now use this inside the post '/' do

# redirect to("/review?#{query}")
