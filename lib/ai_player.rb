require_relative './game.rb'

class AiPlayer
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

  def valid_guess
    options = make_options
    choice = options.is_a?(String) ? options : choose_best_option(options)
    sleep(1)
    puts choice
    choice
  end

  # Begin Private Methods, Internal Use Only
  private

  def score(letters_left, num_players)
    loss_factor = letters_left % num_players
    rounds_left = letters_left / num_players
    if loss_factor != BAD_NUMBER
      return 2 if rounds_left.zero?
      1
    else
      return -1 if rounds_left > 0
      -2
    end
  end

  def valid_fragment?(fragment, word)
    word.start_with?(fragment)
  end

  def word?(fragment, word)
    fragment.length + 1 == word.length
  end

  def add_key_val(options, word, fragment, num_players)
    next_letter = word[fragment.length]
    letters_left = word.length - fragment.length - 1
    options[next_letter] += score(letters_left, num_players) unless next_letter.nil?
  end

  def make_options
    fragment = @game.fragment
    num_players = @game.players.length
    fragment_length = fragment.length
    options = Hash.new(0)

    @dictionary.each_key do |word|
      next unless valid_fragment?(fragment, word)
      next_letter = word[fragment_length]
      return next_letter if word?(fragment, word)
      add_key_val(options, word, fragment, num_players)
    end

    options
  end

  def choose_best_option(options)
    options.key(options.values.max)
  end
end

if $PROGRAM_NAME == __FILE__
  test_player = AI_Player.new
  p test_player.valid_guess
end
