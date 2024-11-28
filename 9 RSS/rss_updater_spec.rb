require 'rss'
require 'json'
require 'open-uri'
require_relative 'rss_updater.rb'

RSpec.describe RSSUpdater do
  let(:feed_urls) { ['https://example.com/rss.xml'] }
  let(:output_file) { 'test_output.json' }
  let(:update_interval) { 10 }
  let(:updater) { RSSUpdater.new(feed_urls, output_file, update_interval) }

  before do
    # Створення фейкового RSS-каналу
    fake_rss = <<~RSS
      <rss version="2.0">
        <channel>
          <title>Test Feed</title>
          <link>https://example.com</link>
          <description>Test RSS Feed Description</description>
          <item>
            <title>Test Item</title>
            <link>https://example.com/test-item</link>
            <description>Test Item Description</description>
            <pubDate>Wed, 27 Nov 2024 12:00:00 GMT</pubDate>
          </item>
        </channel>
      </rss>
    RSS

    allow(URI).to receive(:open).and_return(StringIO.new(fake_rss))
  end

  after do
    # Видалення тимчасового файлу після тестів
    File.delete(output_file) if File.exist?(output_file)
  end

  describe '#fetch_feeds' do
    it 'завантажує RSS-канали та повертає їх у вигляді масиву' do
      feeds = updater.fetch_feeds
      expect(feeds).to be_an(Array)
      expect(feeds.size).to eq(1)

      feed = feeds.first
      expect(feed[:title]).to eq('Test Feed')
      expect(feed[:link]).to eq('https://example.com')
      expect(feed[:description]).to eq('Test RSS Feed Description')
      expect(feed[:items].size).to eq(1)

      item = feed[:items].first
      expect(item[:title]).to eq('Test Item')
      expect(item[:link]).to eq('https://example.com/test-item')
      expect(item[:description]).to eq('Test Item Description')
      expect(item[:pubDate]).to eq('Wed, 27 Nov 2024 12:00:00 GMT')
    end
  end

  describe '#save_to_json' do
    it 'зберігає RSS-дані у JSON-файл' do
      data = [{ title: 'Test Feed', link: 'https://example.com', description: 'Test RSS Feed Description', items: [] }]
      updater.save_to_json(data)

      expect(File.exist?(output_file)).to be true
      saved_data = JSON.parse(File.read(output_file), symbolize_names: true)
      expect(saved_data).to eq(data)
    end
  end

  describe '#start' do
    it 'оновлює RSS-канали та зберігає дані у JSON-файл (одноразовий запуск)' do
      allow(updater).to receive(:loop).and_yield
      expect(updater).to receive(:fetch_feeds).and_call_original
      expect(updater).to receive(:save_to_json).with(instance_of(Array)).and_call_original

      updater.start
      expect(File.exist?(output_file)).to be true
    end
  end
end