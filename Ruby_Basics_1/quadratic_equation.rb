puts "Enter coeff a: "
a = gets.to_f
puts "Enter coeff b: "
b = gets.to_f
puts "Enter coeff c: "
c = gets.to_f

d = b ** 2 - 4 * a * c

if d >= 0 
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)

  x1 == x2 ? (puts x1) : (puts x1, x2)
else 
  puts "No root"
end
