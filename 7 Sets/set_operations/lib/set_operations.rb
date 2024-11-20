require_relative "set_operations/version"

module SetOperations
  class Set
    attr_reader :elements

    def initialize(elements = [])
      @elements = elements.uniq
    end

    def union(other)
      Set.new(@elements | other.elements)
    end

    def intersection(other)
      Set.new(@elements & other.elements)
    end

    def difference(other)
      Set.new(@elements - other.elements)
    end

    def to_s
      @elements.to_s
    end
  end
end