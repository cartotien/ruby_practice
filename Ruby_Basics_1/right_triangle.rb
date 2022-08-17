triangle_sides = []

3.times do 
  puts "Enter triangle side length: "
  triangle_sides << gets.to_f
end

triangle_sides.sort!

hypotenuse_side = triangle_sides[2]
side_1 = triangle_sides[1]
side_2 = triangle_sides[0]

if hypotenuse_side ** 2 == side_1 ** 2 + side_2 ** 2
  puts "Triangle is right"
elsif hypotenuse_side ** 2 > side_1 ** 2 + side_2 ** 2
  puts "Triangle is isosceles"
elsif hypotenuse_side ** 2 < side_1 ** 2 + side_2 ** 2
  puts "Triangle is equilateral"
end
