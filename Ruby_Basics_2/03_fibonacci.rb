fib = [0, 1]

until fib.last >= 100
  fib << fib.last(2).sum
end

puts fib
