#!/usr/bin/ruby

if ARGV.size != 1
  puts "Argumento incorrecto"
end

argument  = ARGV[0]
content   = `cat #{argument}`
usernames = content.split("\n")

usernames.each do |username|
  if system("id #{username} &> /dev/null") == true
    `userdel -r #{username} &> /dev/null`
    puts "Usuario #{username} borrado."
  else
    puts "El usuario #{username} no existe."
  end
end
