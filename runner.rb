require './lib/connect_four'

def print_board(connect_four)
  system 'clear'
  puts connect_four.board.render
end

def player_turn(connect_four)
  puts "It's your turn! What column would you like to place your piece?"
  column = gets.chomp.upcase
  until connect_four.board.get_columns.include? column
    puts "Please enter a valid column"
    column = gets.chomp.upcase
  end
  piece = connect_four.take_player_turn(column)
  unless piece
    print_board(connect_four)
    puts "That column is full"
    return player_turn(connect_four)
  end
  return piece
end

def computer_turn(connect_four)
  puts "It's the computer's turn. The computer is thinking..."
  sleep(2)
  piece = connect_four.take_computer_turn
  return piece
end

def check_player_win(connect_four, piece)
  if connect_four.check_for_win_state(piece)
    puts "You won! Congratulations!"
    return true
  elsif connect_four.check_for_draw
    puts "It's a tie."
    return true
  end
end

def check_computer_win(connect_four, piece)
  if connect_four.check_for_win_state(piece)
    puts "The computer won... you should be ashamed :`("
    return true
  elsif connect_four.check_for_draw
    puts "It's a tie."
    return true
  end
end

def game_loop(connect_four)
  print_board(connect_four)
  piece = player_turn(connect_four)
  print_board(connect_four)
  game_over = check_player_win(connect_four, piece)
  return false if game_over
  piece = computer_turn(connect_four)
  print_board(connect_four)
  game_over = check_computer_win(connect_four, piece)
  return false if game_over
  return true
end

def play(connect_four)
  keep_playing = true
  while keep_playing
    keep_playing = game_loop(connect_four)
  end
  choice = nil
  while choice != "P" && choice != "Q"
    puts "Press (p) to play again. Press (q) to quit."
    choice = gets.chomp.upcase
  end
  return true if choice == "P"
  return false
end

loop do
  puts "Welcome to Connect Four!"
  puts "How long would you like the board to be?"
  length = gets.chomp.to_i
  until length.class == Integer && length >= 0
    puts "Please enter a valid length"
  end
  puts "How tall would you like the board to be?"
  height = gets.chomp.to_i
  until height.class == Integer && height >= 0
    puts "Please enter a valid height"
  end
  puts "How many pieces in a row do you need to win? (Remember, this is connect FOUR)"
  win_number = gets.chomp.to_i
  until win_number.class == Integer && win_number >= 0
    puts "Please enter a valid number"
  end
  connect_four = ConnectFour.new(length, height, win_number)
  play_again = play(connect_four)
  break unless play_again
end
