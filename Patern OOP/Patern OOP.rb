class Handler
  def handle(request)
    puts "Обробник за замовчуванням: не можу обробити запит."
  end
end

class FirstLevelSupport < Handler
  def handle(request)
    if request == 'simple_issue'
      puts 'Перша лінія підтримки обробляє запит.'
    else
      super # Передаємо запит наступному обробнику
    end
  end
end

class SecondLevelSupport < Handler
  def handle(request)
    if request == 'complex_issue'
      puts 'Друга лінія підтримки обробляє запит.'
    else
      super # Якщо не може обробити, передає далі
    end
  end
end

# Створюємо обробники
first_support = FirstLevelSupport.new
second_support = SecondLevelSupport.new

# Зв'язуємо їх
first_support.instance_variable_set(:@next_handler, second_support)

# Метод обробки з можливістю передачі запиту
def handle_request(handler, request)
  # Спробувати обробити запит поточним обробником
  handled = handler.handle(request)

  # Якщо запит не був оброблений, продовжуємо до наступного обробника
  if !handled
    next_handler = handler.instance_variable_get(:@next_handler)
    handle_request(next_handler, request) if next_handler # Рекурсивний виклик для наступного обробника
  end
end

# Тестові запити
requests = ['simple_issue', 'complex_issue', 'unknown_issue']

# Виводимо процес обробки
requests.each do |request|
  puts "Обробка запиту: #{request}"
  handle_request(first_support, request)
  puts "----"
end

