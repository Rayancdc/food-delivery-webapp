require_relative 'base_repository'
require_relative '../models/customer.rb'
class CustomerRepository < BaseRepository
  def initialize(csv_filepath)
    super(csv_filepath)
  end

  def create_object(row)
    row[:id] = row[:id].to_i
    Customer.new(row)
  end

  private

  def update_csv
    CSV.open(@csv_filepath, "wb", CSV_OPTIONS) do |csv|
      csv << ["id", "name", "address"]
      @elements.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
