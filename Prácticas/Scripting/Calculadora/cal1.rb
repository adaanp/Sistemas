#!/usr/bin/ruby

number1 = ARGV[0].to_i
operation = ARGV[1]
number2 = ARGV[2].to_i

if operation == "+"
  puts number1 + number2

elsif operation == "-"
  puts number1 - number2

elsif operation == "x"
  puts number1 * number2

elsif operation == "/"
  puts number1 / number2

else
  puts "Introduzca una operación correcta."

end
