require_relative 'base_controller.rb'
require_relative '../repositories/meal_repository.rb'

class MealsController < BaseController
  def initialize(repository)
    super(repository)
  end

  def list
    @view.display_meals(@repository.all)
  end

  def create_object
    name = @view.ask_name
    price = @view.ask_price
    Meal.new(name: name, price: price)
  end
end
