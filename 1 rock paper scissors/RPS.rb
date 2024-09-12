def game
  puts "Enter your choice:"
  puts "1. Rock"
  puts "2. Paper"
  puts "3. Scissors"

  choice = gets.chomp
  case choice
  when "1"
    playerValue = 0
  when "2"
    playerValue = 1
  when "3"
    playerValue = 2
  else
    puts "Incorrect value, try again"
  end

  randm = Random.new
  botValue = randm.rand(0..2)

  if botValue == playerValue
    puts "We have draw"
  elsif botValue == 0 && playerValue == 1 || botValue == 1 && playerValue == 2 || botValue == 2 && playerValue == 0
    puts "You are winner!!!"
  else
    puts "You are loser))0))000)))00)"
  end
end

game

def menu
  loop do
    puts "Play again?"
    puts "1 - yes, 2 - no"

    choice = gets.chomp
    case choice
    when "1"
      game
    when "2"
      puts "See you next time!"
      break
    else
      puts "Incorrect value, try again"
    end
  end
end

menu