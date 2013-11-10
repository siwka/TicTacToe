TicTacToe
=========

The Program is a Tic Tac Toe game played in a terminal window.

To start a game from command line type:
$  bin/tictactoe

To start a test type:
$


At the beginning of the game you will be prompted to chose a symbol 'o' or 'x' that represents you in the game. Next, you will decide if you or the computer begins the game. At the end, you have the option to start another game or exit the program.

My first attempt to create a code was to use mimimax algorythm. Because this approach is not optional (require many operations) I was considering more efficient versions of minimax: with alpha / beta, and usage of heuristic function. All of those algorithms considers each move to determine the best one, based on analysis of multiple levels. I used the heuristic function, modified it, and added a code for a special case that function result was giving a false game preconceive (user cannot win against computer). This way, my algorithm examine one level of the game with each computer turn, doesn't use recurrence, and has a lower complexity: performs few operations on each steps of the game.
