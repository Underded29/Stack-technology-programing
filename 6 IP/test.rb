require 'rspec'

def valid_ipv4?(ip)
  return false unless ip.is_a?(String) && ip.match?(/^\d+(\.\d+){3}$/)

  parts = ip.split('.')
  parts.all? { |part| part.to_i.to_s == part && part.to_i.between?(0, 255) }
end

RSpec.describe '#valid_ipv4?' do
  context 'when the input is a valid IPv4 address' do
    it 'returns true for a typical address' do
      expect(valid_ipv4?('192.168.1.1')).to be true
    end

    it 'returns true for the lower boundary' do
      expect(valid_ipv4?('0.0.0.0')).to be true
    end

    it 'returns true for the upper boundary' do
      expect(valid_ipv4?('255.255.255.255')).to be true
    end
  end

  context 'when the input is not a valid IPv4 address' do
    it 'returns false for values out of range' do
      expect(valid_ipv4?('256.100.50.0')).to be false
    end

    it 'returns false for missing parts' do
      expect(valid_ipv4?('192.168.1')).to be false
    end

    it 'returns false for extra parts' do
      expect(valid_ipv4?('192.168.1.1.1')).to be false
    end

    it 'returns false for non-numeric characters' do
      expect(valid_ipv4?('192.abc.1.1')).to be false
    end

    it 'returns false for leading zeros' do
      expect(valid_ipv4?('192.168.01.1')).to be false
    end

    it 'returns false for empty string' do
      expect(valid_ipv4?('')).to be false
    end

    it 'returns false for nil input' do
      expect(valid_ipv4?(nil)).to be false
    end
  end
end