require "minitest/autorun"
require_relative "./3 Cut Cake"

class Test_cake < Minitest::Test
  def test_valid
    puts("input:\n.o.o....\n........\n....o...\n........\n.....o..\n........\n\n")
    split_cake(".o.o....\n........\n....o...\n........\n.....o..\n........")

    puts("input:\n........\n..o.....\n....o...\n........\n\n")
    split_cake("........\n..o.....\n....o...\n........")
  end
  def test_invalid
    puts("input:\n.o.o....\n........\n....o...\n\n")
    split_cake(".o.o....\n........\n....o...\n")

    puts("input:\n........\n........\n........\n\n")
    split_cake("........\n........\n........")
  end
end