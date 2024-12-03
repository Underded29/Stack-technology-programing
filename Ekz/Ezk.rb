class Timer
  def self.measure
    start_time = Time.now
    yield
    end_time = Time.now
    elapsed_time = end_time - start_time
    puts "Elapsed time: #{elapsed_time.round(5)} seconds"
    elapsed_time
  end
end

# Використання:
Timer.measure do
  sum = 0
  (1..10000000).each { |i| sum += i }
  puts "Sum: #{sum}"
end