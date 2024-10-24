class Person
  attr_accessor :name, :age
  def initialize(name, age)
    @name = name
    @age = age
  end

  def increase_age
    @age += 1
  end

  def display_info
    puts "Name: #{@name}, Age: #{@age}"
  end
end

person = Person.new("John", 30)
person.display_info  # Output: Name: John, Age: 30
person.increase_age
person.display_info  # Output: Name: John, Age: 31