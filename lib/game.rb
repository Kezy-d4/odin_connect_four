require_relative "board"
require_relative "player"

class Game
  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def play
    activate_first_mover
    turn until over?
  end

  def turn
    puts "#{active_player.id}, it's your turn!\n\n"
    puts "Drop your next token by inputting the number above your desired column.\n\n"
    @board.render
    print "Your input?: "
    index = player_input
    @board.drop_token_in_column(index, active_player.token)
    switch_active_player
    system("clear")
  end

  def over?
    @board.full?
  end

  def active_player
    @player1.active ? @player1 : @player2
  end

  def idle_player
    @player1.active ? @player2 : @player1
  end

  def select_random_player
    [@player1, @player2].sample
  end

  def activate_first_mover
    select_random_player.activate
  end

  def switch_active_player
    players = [@player1, @player2]
    currently_active = players.find { |player| player.active == true }
    currently_idle = players.find { |player| player.active == false }
    currently_active.deactivate
    currently_idle.activate
  end

  def player_input
    loop do
      # We subtract one from the player's input because we present them with
      # non-zero based options.
      index = active_player.choose_column - 1
      return index if valid_player_input?(index)

      print "Invalid input. Please try again: "
    end
  end

  def valid_player_input?(index)
    index.between?(0, Board::WIDTH - 1) && @board.column_available?(index)
  end
end
