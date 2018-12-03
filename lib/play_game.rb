# Start the game off by using necessary classes

require_relative './player.rb'
require_relative './ai_player.rb'
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

# Create AI Player
ai_player = AI_Player.new

# Welcome and get player number
puts 'Welcome to GHOST! Ooh, it’s spooooooky!'
puts
puts 'How many players?'
puts 'Select 1 to play against the AI.'
ghost = Game.new(gets.chomp.to_i, ai_player)
puts

# Share game instance w/ AI
ai_player.add_game(ghost)

# Show who's playing
player_names = ghost.players.map(&:name)
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