require "set_operations"

RSpec.describe SetOperations::Set do
  let(:set_a) { SetOperations::Set.new([1, 2, 3]) }
  let(:set_b) { SetOperations::Set.new([3, 4, 5]) }

  it "creates a set with unique elements" do
    set = SetOperations::Set.new([1, 2, 2, 3])
    expect(set.elements).to eq([1, 2, 3])
  end

  it "computes the union of two sets" do
    union = set_a.union(set_b)
    expect(union.elements).to eq([1, 2, 3, 4, 5])
  end

  it "computes the intersection of two sets" do
    intersection = set_a.intersection(set_b)
    expect(intersection.elements).to eq([3])
  end

  it "computes the difference of two sets" do
    difference = set_a.difference(set_b)
    expect(difference.elements).to eq([1, 2])
  end
end