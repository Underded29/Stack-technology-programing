require 'rss'
require 'json'
require 'open-uri'

class RSSUpdater
  def initialize(feed_urls, output_file, update_interval = 3600)
    @feed_urls = feed_urls
    @output_file = output_file
    @update_interval = update_interval
  end

  # Завантажує та обробляє RSS-канали
  def fetch_feeds
    feeds = []

    @feed_urls.each do |url|
      begin
        URI.open(url) do |rss|
          feed = RSS::Parser.parse(rss, false)
          feeds << {
            title: feed.channel.title,
            link: feed.channel.link,
            description: feed.channel.description,
            items: feed.items.map do |item|
              {
                title: item.title,
                link: item.link,
                pubDate: item.pubDate,
                description: item.description
              }
            end
          }
        end
      rescue => e
        puts "Помилка при завантаженні #{url}: #{e.message}"
      end
    end

    feeds
  end

  # Зберігає дані у JSON-файл
  def save_to_json(data)
    File.open(@output_file, 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end
  end

  # Запускає цикл оновлення
  def start
    loop do
      puts "Оновлення RSS-каналів..."
      feeds = fetch_feeds
      save_to_json(feeds)
      puts "Дані оновлено. Наступне оновлення через #{@update_interval} секунд."
      sleep @update_interval
    end
  end
end

# Налаштування
feed_urls = %w[
  https://rss.nytimes.com/services/xml/rss/nyt/World.xml
  https://feeds.bbci.co.uk/news/rss.xml
]
output_file = 'rss_feeds.json'

# Запуск
updater = RSSUpdater.new(feed_urls, output_file, 1800) # Оновлення кожні 30 хвилин
updater.start