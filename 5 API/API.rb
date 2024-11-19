require 'net/http'
require 'json'
require 'csv'

# Для тестування програми: rspec spec/test_file.rb

def fetch_exchange_rates(base_currency)
  api_url = "https://v6.exchangerate-api.com/v6/f3f4c83615f3ec19531e25a1/latest/#{base_currency}"
  uri = URI(api_url)

  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  if data["result"] == "success"
    data["conversion_rates"]
  else
    raise "Не вдалося отримати дані від API: #{data['error-type']}"
  end
end

def save_to_csv(rates, filename)
  CSV.open(filename, "w") do |csv|
    csv << ["Валюта", "Курс"]
    rates.each do |currency, rate|
      csv << [currency, rate]
    end
  end
end

begin
  base_currency = "USD"
  rates = fetch_exchange_rates(base_currency)
  selected_currencies = %w[EUR GBP UAH CAD JPY]
  filtered_rates = rates.select { |currency, _| selected_currencies.include?(currency) }
  filename = "exchange_rates.csv"
  save_to_csv(filtered_rates, filename)
  puts "Дані успішно збережені у файл #{filename}"
rescue StandardError => e
  puts "Сталася помилка: #{e.message}"
end