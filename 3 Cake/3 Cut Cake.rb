def split_cake(input)
  cake = []
  rows = input.split("\n")
  for i in 0...rows.size
    cols = rows[i].split("")
    cake.push(cols)
  end

  raisins = []
  for x in 0...cake.size
    for y in 0...cake[0].size
      if cake[x][y] == "o"
        raisins.push([x, y])
      end
    end
  end
  if raisins.size <= 1 || raisins.size > 10
    puts "Не вірна кількість родзинок!"
    return
  end

  total_size = cake.size * cake[0].size
  if total_size % raisins.size != 0
    puts "Помилка! Цей пиріг не ділиться на рівні частини"
    return
  end

  piece_size = total_size / raisins.size
  occupied = []
  for i in 0...cake.size
    row = []
    for j in 0...cake[0].size
      row.push(false)
    end
    occupied.push(row)
  end

  pieces = []
  for i in 0...raisins.size
    x = raisins[i][0]
    y = raisins[i][1]
    piece = find_piece(x, y, cake, piece_size, occupied)
    if piece
      pieces.push(piece)
    else
      puts "Помилка! Цей пиріг не  можна поділити націло по одній родзинці"
      return
    end
  end
  puts "Шматки:"
  for i in 0...pieces.size
    display_piece(pieces[i])
  end
end

def find_piece(x, y, cake, piece_size, occupied)
  for height in 1..cake.size
    for width in 1..cake[0].size
      if width * height != piece_size
        next
      end
      for start_x in 0..(cake.size - height)
        if x < start_x || x >= start_x + height
          next
        end
        for start_y in 0..(cake[0].size - width)
          if y < start_y || y >= start_y + width
            next
          end
          if valid_piece(start_x, start_y, width, height, cake, occupied)
            mark_occupied(start_x, start_y, width, height, occupied)
            return create_piece(start_x, start_y, width, height, cake)
          end
        end
        for start_x in 0..(cake.size - width)
          for start_y in 0..(cake[0].size - height)
            if valid_piece(start_x, start_y, height, width, cake, occupied)
              mark_occupied(start_x, start_y, height, width, occupied)
              return create_piece(start_x, start_y, height, width, cake)
            end
          end
        end
      end
    end
  end
  return nil
end

def valid_piece(start_x, start_y, width, height, cake, occupied)
  raisin_count = 0
  for i in start_x...(start_x + height)
    for j in start_y...(start_y + width)
      if occupied[i][j]
        return false
      end
      if cake[i][j] == "o"
        raisin_count += 1
      end
    end
  end
  return raisin_count == 1
end

def mark_occupied(start_x, start_y, width, height, occupied)
  for i in start_x...(start_x + height)
    for j in start_y...(start_y + width)
      occupied[i][j] = true
    end
  end
end

def create_piece(start_x, start_y, width, height, cake)
  piece = []
  for i in start_x...(start_x + height)
    row = []
    for j in start_y...(start_y + width)
      row.push(cake[i][j])
    end
    piece.push(row)
  end
  return piece
end

def display_piece(piece)
  for i in 0...piece.size
    puts piece[i].join("")
  end
  puts ",\n"
end

def main
  puts("Введіть без пробілів пирог+END або exitEND")
  $/ = "END"
  input = STDIN.gets
  $/ = "\n"
  input.chomp!("END")
  puts(input.inspect)
  input.strip!
  if input.strip == "exit"
    exit
  else
    split_cake(input)
  end
end

if __FILE__ == $0
  main
end