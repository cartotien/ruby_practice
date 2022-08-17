cart = {}
total_price = 0

puts "\nWelcome to the shopping cart app.\n\nEnter products or type 'stop' to stop application and get a list of your products.\n\n"

loop do
  puts "\nEnter product name or type 'stop': "
  product_name = gets.chomp

  break if product_name.downcase == "stop"
  
  puts "Enter product's price: "
  product_price = gets.to_f

  puts "Enter desired quantity: "
  product_quantity = gets.to_f

  total_price += product_quantity * product_price

  cart[product_name.to_sym] = {:quantity => product_quantity, :price => product_price, :total => product_quantity * product_price}

end

puts "Your products are #{cart}"
puts "Your total is #{total_price}$"
