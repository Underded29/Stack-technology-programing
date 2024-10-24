
puts "Введіть рік:"
year = gets.chomp.to_i
while year < 0
  puts "Не вірне значення, повторіть введення"
  year = gets.chomp
end

if year % 4 == 0 && year % 100 != 0 ||  year % 400 == 0
  puts "Рік високосний!"
else
  puts "Рік невисокосний"
end
