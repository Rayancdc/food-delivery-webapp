require_relative 'base_repository'
require_relative '../models/employee.rb'
class EmployeeRepository < BaseRepository
  def initialize(csv_filepath)
    super(csv_filepath)
  end

  undef_method :add

  def create_object(row)
    row[:id] = row[:id].to_i
    Employee.new(row)
  end

  def all_delivery_guys
    @elements.select { |employee| employee.delivery_guy? }
  end

  def find_by_username(username)
    @elements.find { |employee| employee.username == username }
  end

  private

  def update_csv
    CSV.open(@csv_filepath, "wb", CSV_OPTIONS) do |csv|
      csv << ["id", "username", "password", "role"]
      @elements.each do |employee|
        csv << [employee.id, employee.username, employee.password, employee.role]
      end
    end
  end
end
