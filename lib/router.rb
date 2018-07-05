# TODO: implement the router of your app.
class Router
  def initialize(controllers = {})
    @meals_controller = controllers[:meals]
    @sessions_controller = controllers[:sessions]
    @customers_controller = controllers[:customers]
    @orders_controller = controllers[:orders]
    @running = true
    @logged_in = false
  end

  def run
    puts ""
    puts "Welcome to Food Express!!!"
    puts "Your food at the right time."
    puts ""

    until @logged_in
      break unless @running
      display_log_options
      choice = gets.chomp.to_i
      print `clear`
      @user = log_in(choice)
    end

    while @running
      case @user
      when Customer
        display_customer_options
        action = gets.chomp.to_i
        print `clear`
        customer_action(action)
      when Employee
        if @user.role.downcase == "manager"
          display_manager_options
          action = gets.chomp.to_i
          print `clear`
          manager_action(action)
        elsif @user.role.downcase == "delivery_guy"
          display_delivery_options
          action = gets.chomp.to_i
          print `clear`
          delivery_action(action)
        end
      else
        puts "Something wrong occurred. Please log in again."
        log_off
      end
    end
  end

  def display_log_options
    puts "Please sign in:"
    puts "1 - Customer"
    puts "2 - Employee"
    puts "3 - Close program"
  end

  def log_in(choice)
    case choice
    when 1
      @logged_in = true
      @customers_controller.sign_in
    when 2
      @logged_in = true
      @sessions_controller.sign_in
    when 3
      stop
    else
      puts "Please press a valid option number"
    end
  end

  def stop
    @running = false
  end

  def log_off
    @logged_in = false
    @user = nil
    run
  end

  def display_customer_options
    puts "1 - List all meals"
    puts "2 - Place Order"
    puts "3 - View my orders"
    puts "4 - Logoff"
  end

  def customer_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @orders_controller.place_order(@user)
    when 3 then @orders_controller.list_customer_orders(@user)
    when 4 then log_off
    else
      puts "Please press a valid option number"
    end
  end

  def display_manager_options
    puts "1 - List all meals"
    puts "2 - Add a meal"
    puts "3 - Delete a meal"
    puts "4 - List all customers"
    puts "5 - Add a customer"
    puts "6 - Delete a customer"
    puts "7 - List all undelivered orders"
    puts "8 - Add an order for a customer"
    puts "9 - Logoff"
  end

  def manager_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @meals_controller.delete
    when 4 then @customers_controller.list
    when 5 then @customers_controller.add
    when 6 then @customers_controller.delete
    when 7 then @orders_controller.list_undelivered_orders
    when 8 then @orders_controller.add
    when 9 then log_off
    else
      puts "Please press a valid option number"
    end
  end

  def display_delivery_options
    puts "1 - View my undelivered orders"
    puts "2 - Mark order as delivered"
    puts "3 - Logoff"
  end

  def delivery_action(action)
    case action
    when 1 then @orders_controller.list_my_orders(@user)
    when 2 then @orders_controller.mark_as_delivered(@user)
    when 3 then log_off
    else
      puts "Please press a valid option number"
    end
  end
end


