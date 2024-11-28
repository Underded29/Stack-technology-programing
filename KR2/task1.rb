class Figure
  def area
    raise NotImplementedError, "Метод площа має бути перевизначений"
  end
end

class Square < Figure
  def initialize(side)
    @side = side
  end

  def area
    @side ** 2
  end
end

class Triangle < Figure
  def initialize(base, height)
    @base = base
    @height = height
  end

  def area
    0.5 * @base * @height
  end
end

square = Square.new(4)
puts square.area # 16

triangle = Triangle.new(3, 6)
puts triangle.area # 9
