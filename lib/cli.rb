# Coordinates a game of Connect Four on the command line
class CLI
  def initialize(game)
    @game = game
  end

  def play
    @game.activate_first_mover
    loop do
      system("clear")
      turn
      break if @game.over?

      @game.switch_active_player
    end
    system("clear")
    ending_message
  end

  private

  def turn
    puts "#{@game.active_player.id}, it's your turn!\n\n"
    puts "Drop your next token by inputting the number above your desired column.\n\n"
    @game.board.render
    print "Your input?: "
    column_index = @game.player_input
    @game.board.drop_token_in_column(column_index, @game.active_player.token)
  end

  def ending_message
    if @game.active_player_wins?
      puts "#{@game.active_player.id} wins!\n\n"
    else
      puts "It's a draw!\n\n"
    end
    @game.board.render
  end
end
