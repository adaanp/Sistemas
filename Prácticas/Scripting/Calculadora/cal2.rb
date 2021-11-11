#!/usr/bin/ruby

arg = ARGV[0]
content = `cat #{arg}`
lines = content.split("\n")

lines.each do |d|
  fields = d.split
  number1 = fields[0].to_i
  number2 = fields[2].to_i
  operation = fields[1]

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
end
