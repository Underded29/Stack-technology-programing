class Dictionary
  attr_accessor :date

  def initialize(date = {})
    @date = date
  end

  def +(other)
    Dictionary.new(@date.merge(other.date))
  end
end

word1 = Dictionary.new({ "apple" => "яблуко", "dog" => "пес" })
word2 = Dictionary.new({ "cat" => "кіт", "apple" => "яблуко" })

result = word1 + word2
puts result.date
# {"apple"=>"яблуко", "dog"=>"пес", "cat"=>"кіт"}
