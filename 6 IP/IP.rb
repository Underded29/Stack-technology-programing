def valid_ipv4?(ip)
  # Перевіряємо, чи рядок відповідає формату IPv4
  return false unless ip.is_a?(String) && ip.match?(/^\d+(\.\d+){3}$/)

  # Розбиваємо рядок на числа, розділені крапками
  parts = ip.split('.')

  # Перевіряємо кожну частину: чи є числом від 0 до 255 та чи відсутні ведучі нулі
  parts.all? { |part| part.to_i.to_s == part && part.to_i.between?(0, 255) }
end