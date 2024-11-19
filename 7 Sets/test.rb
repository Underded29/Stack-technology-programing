require 'set'
require 'minitest/autorun'

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

  # Перевірка рівності множин
  def ==(other)
    @elements == other.elements
  end

  # Перетворення в рядок для зручного виведення
  def to_s
    "{#{elements.to_a.join(', ')}}"
  end
end

# Тести
class CustomSetTest < Minitest::Test
  def setup
    @set1 = CustomSet.new([1, 2, 3, 4])
    @set2 = CustomSet.new([3, 4, 5, 6])
  end

  def test_union
    expected = CustomSet.new([1, 2, 3, 4, 5, 6])
    result = @set1.union(@set2)
    assert_equal expected, result, "Union operation failed"
  end

  def test_intersection
    expected = CustomSet.new([3, 4])
    result = @set1.intersection(@set2)
    assert_equal expected, result, "Intersection operation failed"
  end

  def test_difference
    expected = CustomSet.new([1, 2])
    result = @set1.difference(@set2)
    assert_equal expected, result, "Difference operation failed"
  end

  def test_empty_union
    empty_set = CustomSet.new([])
    result = @set1.union(empty_set)
    assert_equal @set1, result, "Union with empty set failed"
  end

  def test_empty_intersection
    empty_set = CustomSet.new([])
    result = @set1.intersection(empty_set)
    assert_equal empty_set, result, "Intersection with empty set failed"
  end

  def test_empty_difference
    empty_set = CustomSet.new([])
    result = @set1.difference(empty_set)
    assert_equal @set1, result, "Difference with empty set failed"
  end
end