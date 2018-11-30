# Start the game off by using necessary classes

require_relative './player.rb'
require_relative './game.rb'

# Welcome and get player number
puts 'Welcome to GHOST! Ooh, it’s spooooooky!'
puts
puts 'How many players?'
ghost = Game.new(gets.chomp.to_i)

# Show who's playing
player_names = ghost.players.map { |player| player.name }
puts "Playing today, we have: #{player_names.join(', ')}"
