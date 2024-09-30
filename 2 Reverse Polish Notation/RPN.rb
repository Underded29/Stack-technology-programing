puts "Введіть приклад: "
example = gets.chomp

begin
  result = eval(example)
rescue ZeroDivisionError
  abort("Ділення на 0 недопустиме!")
end

$stack = []
$priority = []
$result = []

# Метод для порівняння пріоритетів
def isGreater(coef)
  return false if $priority.empty?

  # Перевіряємо останній елемент у пріоритетах
  last_priority = $priority.last
  last_priority >= coef
end

def checkElem(elem)
  puts $stack.inspect
  puts $priority.inspect
  puts $result.inspect
  array = (0..9).to_a

  case elem
  when '('
    $stack.push(elem)
    $priority.push(0)
  when ')'
    # Витягуємо все до відкритої дужки
    until $stack.empty? || $stack.last == '('
      $result.push($stack.pop)
      $priority.pop
    end
    # Видаляємо відкриту дужку
    $stack.pop
    $priority.pop
  when /\d/ # Обробка чисел
    $result.push(elem)
  when '^'
    while isGreater(4)
      $result.push($stack.pop)
      $priority.pop
    end
    $stack.push(elem)
    $priority.push(4)
  when '*', '/'
    while isGreater(3)
      $result.push($stack.pop)
      $priority.pop
    end
    $stack.push(elem)
    $priority.push(3)
  when '+', '-'
    while isGreater(2)
      $result.push($stack.pop)
      $priority.pop
    end
    $stack.push(elem)
    $priority.push(2)
  else
    abort("Помилка: некоректний елемент у виразі!")
  end
end

# Основна логіка обробки прикладу
example.delete(' ').each_char do |char|
  checkElem(char)
end

# Після завершення виразу витягнути все, що залишилося в стеку
until $stack.empty?
  $result.push($stack.pop)
  $priority.pop
end

puts "Результат: #{$result.join(' ')}"