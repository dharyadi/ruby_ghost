require_relative './game.rb'

class AI_Player
  def initialize
    @dictionary = Game.share_dictionary
    @name = 'AI Bot'
  end

  def valid_guess
    fragment = Game.share_fragment
    puts "Bot says #{fragment}"
  end
end