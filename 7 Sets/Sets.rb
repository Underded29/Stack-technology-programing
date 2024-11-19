require 'set'

# Клас для роботи з множинами
class CustomSet
  attr_reader :elements

  def initialize(elements = [])
    @elements = Set.new(elements)
  end

  # Операція об'єднання
  def union(other_set)
    CustomSet.new(@elements | other_set.elements)
  end

  # Операція перетину
  def intersection(other_set)
    CustomSet.new(@elements & other_set.elements)
  end

  # Операція різниці
  def difference(other_set)
    CustomSet.new(@elements - other_set.elements)
  end

  # Перетворення в рядок для зручного виведення
  def to_s
    "{#{elements.to_a.join(', ')}}"
  end
end

# Приклад використання
set1 = CustomSet.new([1, 2, 3, 4])
set2 = CustomSet.new([3, 4, 5, 6])

puts "Set 1: #{set1}"
puts "Set 2: #{set2}"

# Об'єднання
union_set = set1.union(set2)
puts "Union: #{union_set}"

# Перетин
intersection_set = set1.intersection(set2)
puts "Intersection: #{intersection_set}"

# Різниця
difference_set = set1.difference(set2)
puts "Difference (Set1 - Set2): #{difference_set}"