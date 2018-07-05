class SessionView
  def ask_username
    puts "Please type your username:"
    gets.chomp.to_s
  end

  def ask_password
    puts "Please type your password:"
    gets.chomp.to_s
  end

  def welcome(name)
    puts "Welcome #{name}!"
  end

  def try_again
    puts "Username and password does not match."
    puts "Please try again."
  end

  def clear
    print `clear`
  end
end
