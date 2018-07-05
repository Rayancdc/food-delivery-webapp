require_relative 'base_repository'

class MealRepository < BaseRepository
  def initialize(csv_filepath)
    super(csv_filepath)
  end

  def create_object(row)
    row[:id] = row[:id].to_i
    row[:price] = row[:price].to_i
    Meal.new(row)
  end

  def update_csv
    CSV.open(@csv_filepath, "wb", CSV_OPTIONS) do |csv|
      csv << ["id", "name", "price"]
      @elements.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
