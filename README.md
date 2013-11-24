TicTacToe
=========

The Program is a Tic Tac Toe game played in a terminal window.

To start a game from command line type:
>$ bin/tictactoe

To start a test for files game.rb, console.rb, board.rb respectively type:
>    $ rspec rspec spec/tictactoe/game_spec.rb --format doc  
    $ rspec spec/tictactoe/game_spec.rb --format doc  
    $ rspec spec/tictactoe/board_spec.rb --format doc'  

At the beginning of the game you will be prompted to chose a symbol 'o' or 'x' that represents you in the game. Next, you will decide if you or the computer begins the game. At the end, you have the option to start another game or exit the program.

My first attempt to create a code was to use mimimax algorythm. Because this approach is not optional (require many operations) I was considering more efficient versions of minimax: with alpha / beta, and usage of heuristic function. All of those algorithms considers each move to determine the best one, based on analysis of multiple levels. I used the heuristic function, modified it, and added a code for a special case that function result was giving a false game preconceive (user cannot win against computer). This way, my algorithm examine one level of the game with each computer turn, doesn't use recurrence, and has a lower complexity: performs few operations on each steps of the game.

**heuristc_val mehod explanation**  

        # *** Since our priority is not to let human win (not to win)  
        # *** I changed heurestic function to 3a+b-(4c+d)  
        # estimate value for each node of a game as 3*a+b-(3*c+d)  
        # by analyzing each line: horizontal, vertical and diagonal  
        # variableds a, b, c, d stands for number of lines meeting following criteria:  
        # a: 2 computer player char, 0 human player char in line  
        # b: 1 computer player char, 0 human player char in line  
        # c: 0 computer player char, 2 human player char in line  
        # d: 0 computer player char, 1 human player char in line  

