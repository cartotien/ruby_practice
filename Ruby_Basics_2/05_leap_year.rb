def leap_year?(year)
  (year % 4 == 0) && !(year % 100 == 0) || (year % 400 == 0)
end

days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "\nExample: 17.8.2022\n\nEnter dot separated year: "
date = gets.split('.').to_a.map { |element| element.to_i }

if leap_year?(date[2])
  days_in_months[1] = 29
end

puts "This is the #{date[0] + days_in_months[0...date[1]-1].sum} day of the year"
