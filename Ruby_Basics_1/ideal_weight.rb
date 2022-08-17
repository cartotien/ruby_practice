puts "Enter your name: "
name = gets.chomp

puts "Enter your height: "
height = gets.to_f

ideal_weight = (height-110)*1.15

if ideal_weight > 0
  puts "#{name}, your ideal weight is #{ideal_weight}"
else
  puts "#{name}, your weight is already ideal"
