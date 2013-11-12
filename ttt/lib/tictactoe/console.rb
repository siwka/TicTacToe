require_relative 'game'

class Console
  #attr_reader :message

  def initialize
    clear_screen
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

  # def puts (message)  #this trick makes test to pass & code not to work
  #   @message = message
  # end

  def who_starts?
    puts 'Do you want to make a first move (y/n)?'
    #puts("Who is going to make first move: 1-you, 2-computer?") for test pass with puts()
  end

  def human_starts?
    start_player = gets.chomp.chr
    while start_player != 'y' and start_player !='n'
      puts "this is wrong character, try again!"
      start_player = gets.chomp.chr
    end
    case start_player
    when 'y'
      info_human_starts
      return 1
    when 'n'
      info_computer_starts
      return 0
    end
  end

  def info_human_starts
    puts "\nYou are starting a game."
  end

  def info_computer_starts
    puts "\nComputer is starting a game, chosing first move:\n"
  end

  def chose_symbol?
    puts 'Choose o or x:'
  end

  def human_symbol
    human_player = gets.chomp.chr
    while human_player != 'x' and human_player !='o'
      puts "this is wrong character, try again!"
      human_player = gets.chomp.chr
    end
    human_player
  end

  def draw_empty_board(board_dimention)
    ind_board = []
    [2,1,0].each do |i|
      board_dimention.times do |j|
        ind_board << j+board_dimention*i+1
      end
    end

    puts "\n"
    ind_board.each do |i|
      print " "+ (i).to_s + " "
      if ((i) % board_dimention != 0)
        print "|"
      elsif ((i) != board_dimention)
        print "\n---+---+---\n"
      else
        print "\n"
      end 
    end
    puts "\n"
  end

  def draw_board(board_dimention, board)
    puts "\n"
    (board_dimention*board_dimention).times do |ind|
      if (ind < board_dimention)
        print " " + board[ind+2*board_dimention].to_s + " "     
      elsif (2*board_dimention-1<ind)
        print " " + board[ind-2*board_dimention].to_s + " "
      else
        print " " + board[ind].to_s + " "
      end
      if ((ind+1) % board_dimention != 0)
        print "|"
      elsif ((ind+1) != (board_dimention*board_dimention))
        print "\n---+---+---\n"
      else
        print "\n"
      end 
    end
    puts "\n"
  end

  def game_result(winner)
      if winner = 1
        puts "player x won!"
      elsif winner = 2
        puts "player o won!"
      else
        puts "Game is over - draw!"
      end
  end

  def read_human_move(board)
    print "\nPerson is choosing a move:\nChoose your move (1-9) in an empty space: "    
    # mv = gets.chomp.chr
    # until (["1","2","3","4","5","6","7","8","9"].index(mv)  && (board[mv.to_i - 1] == " "))
    #   puts "this is wrong key, try again!"
    #   mv = gets.chomp.chr
    # end
    begin
      mv = gets.chomp.chr
    end until ["1","2","3","4","5","6","7","8","9"].index(mv) && (board[mv.to_i - 1] == " ")
    # puts mv
    mv = mv.to_i
    mv = mv-1
    return mv
  end

  def print_computer_move(mv)
    puts "Computer choose move to #{mv+1}"
  end

  def ask_if_continue_game
    puts "Play again? (y/n):" 
    begin
      response = gets.chomp.chr
    end until response == 'y' || response == 'n'
    return response
  end
end
