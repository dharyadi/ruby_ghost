require_relative './game.rb'

class AI_Player
  attr_reader :name
  BAD_NUMBER = 1

  def initialize
    @game = nil
    @dictionary = Game.share_dictionary
    @name = 'AI Bot'
  end

  def add_game(game)
    @game = game
  end

  def self.score(loss_factor, rounds_left)
    return 2 if loss_factor != BAD_NUMBER && rounds_left == 0
    return 1 if loss_factor != BAD_NUMBER && rounds_left > 0
    return -1 if loss_factor == BAD_NUMBER && rounds_left > 0
    -2
  end

  def make_options_hash
    fragment = @game.fragment
    num_players = @game.players.length
    options = Hash.new(0)
    fragment_length = fragment.length
    final_fragment_len = fragment.length + 1

    @dictionary.each_key do |word|
      if fragment == word[0...fragment_length]
        next_letter = word[fragment_length]
        return next_letter if final_fragment_len == word.length
        letters_left = word.length - final_fragment_len
        loss_factor = (letters_left) % num_players
        rounds_left = (letters_left) / num_players
        unless next_letter.nil?
          options[next_letter] += AI_Player.score(loss_factor, rounds_left)
        end
      end
    end
    options
  end

  def choose_best_option(options)
    options.key(options.values.max)
  end

  def valid_guess
    options = make_options_hash
    choice = options.is_a?(String) ? options : choose_best_option(options)
    sleep(1)
    puts choice
    choice
  end
end

if $PROGRAM_NAME == __FILE__
  test_player = AI_Player.new
  p test_player.valid_guess
end
