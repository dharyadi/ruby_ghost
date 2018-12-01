require_relative './game.rb'

class AI_Player
  BAD_NUMBER = 1
  @@game = nil

  def initialize
    @dictionary = Game.share_dictionary
    @name = 'AI Bot'
  end

  def self.set_game_instance(game)
    @@game = game
  end

  def self.score(loss_factor, rounds_left)
    return 2 if loss_factor != BAD_NUMBER && rounds_left == 0
    return 1 if loss_factor != BAD_NUMBER && rounds_left > 0
    return -1 if loss_factor == BAD_NUMBER && rounds_left > 0
    -2
  end

  def valid_guess
    # fragment = @@game.fragment
    # players = @@game.players
    fragment = 'ca'
    players = ['T', 'K', 'A']
    options = Hash.new(0)
    final_fragment_len = fragment.length + 1

    @dictionary.each_key do |word|
      if fragment == word[0...fragment.length]
        return word[fragment.length] if final_fragment_len == word.length
        loss_factor = (word.length - final_fragment_len) % players.length
        rounds_left = (word.length - final_fragment_len) / players.length
        options[word[fragment.length]] += AI_Player.score(loss_factor, rounds_left)
      end
    end
    p options
    options.key(options.values.max)
  end
end

if $PROGRAM_NAME == __FILE__
  test_player = AI_Player.new
  p test_player.valid_guess
end
