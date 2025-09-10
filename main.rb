require_relative "lib/game"
require_relative "lib/board"
require_relative "lib/player"

system("clear")
puts "Let's play Connect Four!"
sleep(1.25)

print "Input a name for the player who will play Red: "
player1_name = gets.chomp
print "Input a name for the player who will play Blue: "
player2_name = gets.chomp
system("clear")

game = Game.new(Board.new, Player.new(player1_name, "🔴"), Player.new(player2_name, "🔵"))
game.play
