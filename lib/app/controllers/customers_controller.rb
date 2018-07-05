require_relative 'base_controller.rb'
require_relative '../repositories/customer_repository.rb'

class CustomersController < BaseController
  def initialize(repository)
    super(repository)
  end

  def list
    @view.display_customers(@repository.all)
  end

  def sign_in
    name = @view.ask_name
    customer = find_by_name(name)
    return customer if customer
    address = @view.ask_address
    customer = Customer.new(name: name, address: address)
    @repository.add(customer)
    customer
  end

  def find_by_name(name)
    @repository.all.find { |element| element.name == name}
  end


  def create_object
    name = @view.ask_name
    address = @view.ask_address
    Customer.new(name: name, address: address)
  end
end
