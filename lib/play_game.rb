# Start the game off by using necessary classes

require_relative './player.rb'
require_relative './game.rb'

def valid_response(str)
  until /Y|N|YES|NO/.match(str)
    puts 'Please enter Y, N, YES, or NO.'
    str = gets.chomp.upcase
  end
  str
end

def play_again_response
  puts 'Would you like to play again? (Y/N)'
  valid_response(gets.chomp.upcase)
end

# Welcome and get player number
puts 'Welcome to GHOST! Ooh, it’s spooooooky!'
puts
puts 'How many players?'
ghost = Game.new(gets.chomp.to_i)
puts

# Show who's playing
player_names = ghost.players.map { |player| player.name }
puts "Playing today, we have: #{player_names.join(', ')}"
puts "Let's Begin!"
puts
ghost.play
puts

# Ask if same players would like to play again
response = play_again_response
until /Y|YES/.match(response).nil?
  puts 'Here we go again! Starting new game...'
  puts
  ghost.restart
  response = play_again_response
end
puts
puts 'Hope you enjoyed playing the game!'