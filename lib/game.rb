require_relative "board"
require_relative "player"

# Represents a game of Connect Four between two players
class Game
  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def play # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    activate_first_mover
    loop do
      system("clear")
      puts "#{active_player.id}, it's your turn!\n\n"
      puts "Drop your next token by inputting the number above your desired column.\n\n"
      @board.render
      print "Your input?: "
      column_index = player_input
      @board.drop_token_in_column(column_index, active_player.token)

      if @board.any_winning_line?(active_player.token, @board.most_recent_token_coordinates(column_index))
        system("clear")
        puts "#{active_player.id} wins!\n\n"
        @board.render
        return
      elsif @board.full?
        system("clear")
        puts "It's a draw!\n\n"
        @board.render
        return
      end

      switch_active_player
      system("clear")
    end
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
    currently_active = active_player
    currently_idle = idle_player
    currently_active.deactivate
    currently_idle.activate
  end

  def player_input
    loop do
      # We subtract one from the player's input because we present them with
      # non-zero based options.
      column_index = active_player.choose_column - 1
      return column_index if valid_player_input?(column_index)

      print "Invalid input. Please try again: "
    end
  end

  def valid_player_input?(column_index)
    column_index.between?(0, Board::WIDTH - 1) && @board.column_available?(column_index)
  end
end
