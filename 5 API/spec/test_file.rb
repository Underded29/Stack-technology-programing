require 'net/http'
require 'json'
require 'csv'
require_relative '../API' # Імпорт основного коду

# Для тестування програми: rspec spec/test_file.rb

RSpec.describe 'Exchange Rate API' do
  let(:base_currency) { "USD" }
  let(:mock_response) do
    {
      "result" => "success",
      "conversion_rates" => {
        "EUR" => 0.93,
        "GBP" => 0.81,
        "UAH" => 37.2,
        "CAD" => 1.34,
        "JPY" => 147.3
      }
    }.to_json
  end

  describe '#fetch_exchange_rates' do
    it do
      # Мокаємо HTTP-запит
      allow(Net::HTTP).to receive(:get).and_return(mock_response)

      rates = fetch_exchange_rates(base_currency)
      expect(rates).to be_a(Hash)
      expect(rates).to include("EUR", "GBP", "UAH")
    end

    it do
      error_response = { "result" => "error", "error-type" => "unsupported-code" }.to_json
      allow(Net::HTTP).to receive(:get).and_return(error_response)

      expect { fetch_exchange_rates(base_currency) }.to raise_error(RuntimeError, /Не вдалося отримати дані від API/)
    end
  end

  describe '#save_to_csv' do
    let(:rates) do
      {
        "EUR" => 0.93,
        "GBP" => 0.81,
        "UAH" => 37.2
      }
    end
    let(:filename) { "test_rates.csv" }

    after(:each) do
      File.delete(filename) if File.exist?(filename)
    end

    it do
      save_to_csv(rates, filename)

      expect(File.exist?(filename)).to be true

      csv_content = CSV.read(filename, headers: true)
      expect(csv_content.headers).to eq(["Валюта", "Курс"])
      expect(csv_content[0]["Валюта"]).to eq("EUR")
      expect(csv_content[0]["Курс"]).to eq("0.93")
    end
  end
end