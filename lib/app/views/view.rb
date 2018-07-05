class View
  def clear
    print `clear`
  end

  def ask_name
    puts "What's the name?"
    gets.chomp.to_s
  end

  def ask_address
    puts "What's the address?"
    gets.chomp.to_s
  end

  def ask_price
    puts "What's the price?"
    gets.chomp.to_i
  end

  def ask_id
    puts "What's the id?"
    gets.chomp.to_i
  end

  def ask_meal_id
    puts "What's the meal_id?"
    gets.chomp.to_i
  end

  def ask_meal_id_customer
    puts ""
    puts "What's the id of the meal you want to order?"
    gets.chomp.to_i
  end

  def ask_customer_id
    puts "What's the customer_id?"
    gets.chomp.to_i
  end

  def ask_order_id
    puts "What's the order_id?"
    gets.chomp.to_i
  end

  def ask_employee_id
    puts "What's the employee_id?"
    gets.chomp.to_i
  end

  def display_orders(orders)
    clear
    orders.each do |e|
      puts "#{e.id} - #{e.customer.name}, #{e.customer.address} - Meal: #{e.meal.name}, Employee: #{e.employee.username}"
    end
  end

  def display_to_customer(orders)
    clear
    puts "Hello #{orders.first.customer.name}. This is your order history:"
    orders.each do |order|
      delivered = order.delivered? ? "Delivered" : "On the way"
      # Hora que foi feito o pedido. O que foi pedido. Preço. Nome do entregador. Endereço
      puts "#{order.time} | #{order.meal.name} ($#{format("%.2f",order.meal.price)}) | #{delivered} | Delivery guy: #{order.employee.username} | Address: #{order.customer.address}"
    end
  end

  def display_all(elements)
    clear
    elements.each do |element|
      puts "ID: #{element.id} - #{element.name}"
    end
  end

  def display_meals(elements)
    clear
    elements.each do |element|
      puts "ID: #{element.id} - #{element.name} - $#{format("%.2f",element.price)}"
    end
  end

  def display_customers(elements)
    clear
    elements.each do |element|
      puts "ID: #{element.id} - #{element.name} - #{element.address}"
    end
  end

  def display_employees(elements)
    clear
    elements.each do |element|
      puts "ID: #{element.id} - #{element.username} - #{element.role}"
    end
  end
end
