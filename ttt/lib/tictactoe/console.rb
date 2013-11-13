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

  def get_char
    # commented is better way to play but it dissables Ctr+C
    # system("stty raw -echo")
    # character = STDIN.getc
    # system("stty -raw echo")
    # return character
    gets.chomp.chr
  end

  def human_starts?
    start_player = get_char
    while start_player != 'y' and start_player !='n'
      puts "this is wrong character, try again!"
      start_player = get_char
    end

    if start_player == 'y'
      info_human_starts
      return true
    elsif 'n'
      info_computer_starts
      return false
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
    human_player = get_char
    while human_player != 'x' and human_player !='o'
      puts "this is wrong character, try again!"
      human_player = get_char
    end
    human_player
  end

  def draw_empty_board(board_dimention)
    ind_board = []
    [2,1,0].each do |indx|
      board_dimention.times do |column|
        ind_board << column+board_dimention*indx+1
      end
    end

    puts "\n"
    ind_board.each do |cell|
      print " "+ (cell).to_s + " "
      if ((cell) % board_dimention != 0)
        print "|"
      elsif ((cell) != board_dimention)
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
      if winner == 1
        puts "player x won!"
      elsif winner == 2
        puts "player o won!"
      else
        puts "Game is over - draw!"
      end
  end

  def read_human_move(board)
    print "\nPerson is choosing a move:\nChoose your move (1-9) in an empty space: "    
    # mv = get_char
    # until (["1","2","3","4","5","6","7","8","9"].index(mv)  && (board[mv.to_i - 1] == " "))
    #   puts "this is wrong key, try again!"
    #   mv = get_char
    # end
    begin
      mv = get_char
    end until ["1","2","3","4","5","6","7","8","9"].index(mv) && (board[mv.to_i - 1] == " ")
    mv = mv.to_i
    mv = mv-1
    return mv
  end

  def print_computer_move(mv)
    puts "Computer choose move to #{mv+1}"
  end

  def ask_if_continue_game
    puts "Play again? (y/n):" 
    response = get_char
    until response == 'y' || response == 'n'
      response = get_char
    end
    return response
  end
end
