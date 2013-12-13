require_relative 'IntConst'  # => true, false

module TicTacToe
  class Game
    attr_accessor :current_player, :game_board, :console  # => nil, nil
                                   # :game_board, :console added only bc of testing

    def initialize(output)
      @output = output        # => #<StringIO:0x898f4d8>, #<StringIO:0x898f4d8>
      @console = Console.new  # ~> NameError: uninitialized constant TicTacToe::Game::Console
      @current_player = 'x'   # => "x"
    end

    def start
      @output.puts "Welcome to tic tac toe!\n"  # => nil
      @output.puts "\nLet's start a game:\n"    # => nil
    end

    def set_game
      @console.chose_symbol?                                                                                       # => nil
      @game_board = Board.new(@console.human_symbol)                                                               # => #<Board:0x87d8db0 @board=[" ", " ", " ", " ", " ", " ", " ", " ", " "], @human_player_symbol="x", @comp_player_symbol="o">
      @output.puts "You choose '#{@game_board.human_player_symbol}'"                                               # => nil
      @output.puts "Computer will use '" + @game_board.comp_player_symbol + "'"                                    # => nil
      @output.puts "\nUse numeric pad that mimic a board to play\n"                                                # => nil
      @console.draw_empty_board(@game_board.board_dimention)                                                       # => nil
      @console.who_starts?                                                                                         # => nil
      @current_player = @console.human_starts? ? @game_board.human_player_symbol : @game_board.comp_player_symbol  # ~> NoMethodError: undefined method `chomp' for nil:NilClass
    end

    def game_not_over?
      #(!(winner = won?(@game_board.board)) && (!tie?(@game_board.board)))
      won?(@game_board.board) || tie?(@game_board.board)
    end

    def play
      while !(winner = game_not_over?)
        move(@game_board.board, @current_player)
        @console.draw_board(@game_board.board_dimention, @game_board.board)
        @current_player = switch_player(@current_player)
      end
      @console.game_result(winner)
    end

    def won?(board)
      if player = (won_horizontal?(board) || won_vertical?(board) || won_diagonal?(board))
        return player
      else
        return false
      end  
    end

    def won_horizontal?(b)
      win_line = Array.new(game_board.board_dimention, game_board.comp_player_symbol).join
      if [b[0..2].join, b[3..5].join, b[6..8].join].include?(win_line)
        return game_board.comp_player_symbol
      end
      win_line = Array.new(game_board.board_dimention, game_board.human_player_symbol).join      
      if [b[0..2].join, b[3..5].join, b[6..8].join].include?(win_line)
        return game_board.human_player_symbol
      end
      return false
    end

    def won_vertical?(b)
      win_line = Array.new(game_board.board_dimention, game_board.comp_player_symbol).join
      if [b[0]+b[3]+b[6], b[1]+b[4]+b[7], b[2]+b[5]+b[8]].include?(win_line)
        return game_board.comp_player_symbol
      end
      win_line = Array.new(game_board.board_dimention, game_board.human_player_symbol).join  
      if [b[0]+b[3]+b[6], b[1]+b[4]+b[7], b[2]+b[5]+b[8]].include?(win_line)
        return game_board.human_player_symbol
      end
      return false
    end

    def won_diagonal?(b)
      win_line = Array.new(game_board.board_dimention, game_board.comp_player_symbol).join  
      if [b[0]+b[4]+b[8], b[2]+b[4]+b[6]].include?(win_line)
        return game_board.comp_player_symbol
      end 
      win_line = Array.new(game_board.board_dimention, game_board.human_player_symbol).join  
      if [b[0]+b[4]+b[8], b[2]+b[4]+b[6]].include?(win_line)
        return game_board.human_player_symbol
      end 
      return false  
    end

    def tie?(board)
    # tie if there is no more moves, meaning no space in array
    # to simplyfy we assume that won() was called before tie()
      return board.none? { |b| b == " " }
    end

    def switch_player(current_player)
      if (current_player == @game_board.human_player_symbol)
        current_player = @game_board.comp_player_symbol
      else
        current_player = @game_board.human_player_symbol
      end
    end

    def move(board, current_player)
      if (current_player == @game_board.human_player_symbol)
        mv = human_move(board)
      else
        mv = computer_move(board)
      end
      @game_board.board[mv] = current_player
    end

    def human_move(board)
      mv = @console.read_human_move(board)
    end

    def random_first_move
      [0,1,2,3,4,5,6,7,8].sample
    end

    def board_empty?(board)
      board.count(" ") == 9
    end

    def special_case?(board)
      board.count(" ") == 6 && board[4] == @game_board.comp_player_symbol &&
          ((board[0] == @game_board.human_player_symbol && board[8] == @game_board.human_player_symbol) ||
          (board[2] == @game_board.human_player_symbol && board[6] == @game_board.human_player_symbol))
    end

    def one_best_computer_move?(max_moves)
      max_moves.length == 1
    end

    def extract_best_move(max_moves)
      mv = max_moves[0][1]
    end

    def remove_the_best_chance_for_human(considered_hu, max_moves)
      max_moves.delete([max_moves[0][0], remove_mv(considered_hu, max_moves)])
      mv = max_moves.sample[1]      
    end

    def computer_move(board)    
      if mv = winning_move?(board)
        return mv
      end

      if board_empty?(board)
        mv = random_first_move
      else
        # start with a special case to avoid human moves in 3 corners in 2 empty lines
        if special_case?(board)
          mv = [1,3,5,7].sample
        else
          considered_temp = estimate_moves(board, @game_board.comp_player_symbol)
          considered_mv, considered_hu = considered_temp
          max_moves = selected_from_best_comp_mv(considered_mv)

          # mirror and turned board are the same game cases
          # here we consider only it this is middle board, corner or middle side
          # as 1st, 2nd, and 3rd best choice respectevely
          
          # one only the best move for computer
          if one_best_computer_move?(max_moves)
            mv = extract_best_move(max_moves)
          else
            mv = remove_the_best_chance_for_human(considered_hu, max_moves)
          end
        end
      end
        
      @console.print_computer_move(mv)
      return mv
    end

    def winning_move?(board)
      n = @game_board.board_dimention * @game_board.board_dimention
      n.times do |ind|
        if board[ind] == " "
          board[ind] = @game_board.comp_player_symbol
          if won?(board)
            return ind
          end
          board[ind] = " "
        end
      end
      return false
    end

    def estimate_moves(board, current_player)
      # collect evaluated results for each move
      considered_mv = []
      considered_hu = []

      # analyse each next possible move:
      n = @game_board.board_dimention * @game_board.board_dimention
      n.times do |ind|
        if board[ind] == " "
          board[ind] = current_player
          score = heuristc_val(board)
          board[ind] = " " # clear selection
          considered_mv << score[0]
          considered_hu << score[1]
        else
          considered_mv << IntConst::FIXNUM_MIN # min system int, not to rewrite taken space (move)
          considered_hu << IntConst::FIXNUM_MIN 
        end
      end
      return [considered_mv, considered_hu]
    end   

    def heuristc_val(board)
      temp = [
        # horizontal lines
        board[0..2],
        board[3..5],
        board[6..8],

        # # vertical lines
        board.values_at(0,3,6),
        board.values_at(1,4,7),
        board.values_at(2,5,8),

        # diagonal lines
        board.values_at(0,4,8),
        board.values_at(2,4,6)
        ]

      temp_comp = temp.map {|ele| ele.count{|i| i == @game_board.comp_player_symbol}}
      temp_humn = temp.map {|ele| ele.count{|i| i == @game_board.human_player_symbol}}
      temp_result = temp_comp.zip(temp_humn)

      a = temp_result.count{|i| i == [2,0]}
      b = temp_result.count{|i| i == [1,0]}
      c = temp_result.count{|i| i == [0,2]}
      d = temp_result.count{|i| i == [0,1]}

      return [3*a+b-(4*c+d), 4*c+d]
    end

    def selected_from_best_comp_mv(results)
    # find indexes of all maximums and chose random one
      max_val = results.max
      indexes = []
      maxes = []

      results.each_with_index do |ele, indx|
        temp = []
        temp << ele
        temp << indx
        indexes << temp
      end

      indexes.each do |ele| 
        if ele[0] == max_val
          maxes << ele
        end
      end
      return maxes
    end

    def remove_mv(considered_hu, max_moves)
    # removes from possible good moves the one with biggest potential to lose
      human_max_score = IntConst::FIXNUM_MIN
      rm_mv = -1
      max_moves.length.times do |ind|
        if considered_hu[max_moves[ind][1]] > human_max_score
          human_max_score = considered_hu[max_moves[ind][1]]
          rm_mv = max_moves[ind][1]
        end
      end
      return rm_mv
    end

    def continue_game?
      @console.ask_if_continue_game == 'n' ? true : false
    end
  end
end


# require 'stringio'  # => false, false

# $stdin = StringIO.new("x\n")  # => #<StringIO:0x8904950>, #<StringIO:0x88b9590>

# # begin
#   $LOAD_PATH.unshift "/home/siwka/_dev/ttt/ttt/lib"  # => ["/home/siwka/_dev/ttt/ttt/lib", "/home/siwka/.rvm/gems/ruby-2.0.0-p247/gems/seeing_is_believing-2.0.3/lib", "/home/siwka/.rvm/rubies/ruby-2.0.0-p247/lib/ruby/site_ruby/2.0.0", "/home/siwka/.rvm/rubies/ruby-2.0.0-p247/lib/ruby/site_ruby/2.0.0/i686-linux", "/home/siwka/.rvm/rubies/ruby-2.0.0-p247/lib/ruby/site_ruby", "/home/siwka/.rvm/rubies/ruby-2.0.0-p247/lib/ruby/vendor_ruby/2.0.0", "/home/siwka/.rvm/rubies/ruby-2.0.0-p247/lib/ruby/vendor_ruby/2.0.0/i686-linux", "/home/siwka/.rvm/rubies/ruby-2.0.0-p247/lib/ruby/vendor_ruby", "/home/siwka/.rvm/rubies/ruby-2.0.0-p247/lib/ruby/2.0.0", "/home/siwka/.rvm/rubies/ruby-2.0.0-p247/lib/ruby/2.0.0/i686-linux"], ["/home/siwka/_dev/ttt/ttt/lib", "/home/siwka/_dev/ttt/ttt/lib", "/home/siwka/.rvm/gems/ruby-2.0.0-p247/gems/seeing_is_believing-2.0.3/lib", "/home/siwka/.rvm/rubies/ruby-2.0.0-p247/lib/ruby/site_ruby/2.0.0", "/home/siwka/.rvm/rubies/ruby-2.0.0-p247/lib/ruby/site_ruby/2.0.0/i68...
#   require 'tictactoe'                                # => false, true
#   game = TicTacToe::Game.new(STDOUT)                 # => #<TicTacToe::Game:0x87d94e0 @output=#<StringIO:0x898f4d8>, @console=#<Console:0x87d9454>, @current_player="x">
#   game.start                                         # => nil
#   game.set_game
#   game.play
# # end until game.continue_game?

# # >> [H[2J
# # >> Welcome to tic tac toe!
# # >> 
# # >> Let's start a game:
# # >> Choose your player symbol o or x:
# # >> You choose 'x'
# # >> Computer will use 'o'
# # >> 
# # >> Use numeric pad that mimic a board to play
# # >> 
# # >>  7 | 8 | 9 
# # >> ---+---+---
# # >>  4 | 5 | 6 
# # >> ---+---+---
# # >>  1 | 2 | 3 
# # >> 
# # >> Do you want to make a first move (y/n)?

# # ~> NoMethodError
# # ~> undefined method `chomp' for nil:NilClass
# # ~>
# # ~> /home/siwka/_dev/ttt/ttt/lib/tictactoe/console.rb:29:in `get_char'
# # ~> /home/siwka/_dev/ttt/ttt/lib/tictactoe/console.rb:33:in `human_starts?'
# # ~> /home/siwka/_dev/ttt/ttt/lib/tictactoe/game.rb:27:in `set_game'
# # ~> /home/siwka/_dev/ttt/ttt/lib/tictactoe/game.rb:285:in `<main>'
