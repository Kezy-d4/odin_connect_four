require_relative "lib/board"
require_relative "lib/player"
require_relative "lib/game"
require_relative "lib/cli"

system("clear")
puts "Let's play Connect Four!"
sleep(1.25)

print "Input a name for the player who will play Red: "
player1_name = gets.chomp
print "Input a name for the player who will play Blue: "
player2_name = gets.chomp

loop do
  game = Game.new(Board.new, Player.new(player1_name, "🔴"), Player.new(player2_name, "🔵"))
  cli = CLI.new(game)
  cli.play
  print "Play again?[y/n]: "
  answer = gets.chomp.downcase
  break unless %w[y yes].include?(answer)
end
