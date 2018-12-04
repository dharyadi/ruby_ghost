# All game functions for turns, rounds, wins, losses
require_relative './player.rb'

class Game
  attr_reader :players, :fragment
  MIN_PLAYERS = 1
  MAX_PLAYERS = 4
  DICTIONARY = File.read('dictionary.txt').split(/\n+/).product([nil]).to_h
  LOSING_TEXT = 'GHOST'.freeze

  def initialize(num_players, ai_player)
    # Make player objects
    num_players = Game.validate_num_players(num_players)
    @players = []
    @ai_player = ai_player
    create_players(num_players)
    # Track scores in a hash
    @scores = make_scores_hash
    @fragment = ''
  end

  def make_scores_hash
    @players.map { |player| [player.name, 0] }.to_h
  end

  def self.share_dictionary
    DICTIONARY
  end

  def clear_players
    @players = []
  end

  def reset_scores
    @scores.each_key do |name|
      name == 'AI Bot' ? @players << @ai_player : @players << Player.new(name)
      @scores[name] = 0
    end
  end

  def restart
    # Reset players array w/ same names & reset scores hash
    clear_players
    reset_scores
    play
  end

  def self.welcome_message
    puts "Here we go, let's start a new word!"
  end

  def self.validate_num_players(num_players)
    until (MIN_PLAYERS..MAX_PLAYERS).include?(num_players)
      puts "Please enter a number between #{MIN_PLAYERS} and #{MAX_PLAYERS}."
      num_players = gets.chomp.to_i
    end
    num_players
  end

  def create_players(num_players)
    num_players.times do |num|
      puts "Player #{num + 1} name:"
      @players << Player.new(gets.chomp)
    end
    puts '-----------------------------------------'
    puts
    # Add AI PLayer if only 1 player selected
    @players << @ai_player if num_players == 1
  end

  def self.num_matches(fragment)
    count = 0
    DICTIONARY.each_key do |word|
      count += 1 if word[0...fragment.length] == fragment
    end
    count
  end
  # if only one matching word, return true, otherwise, randomly decide
  def self.fragment_is_word?(fragment)
    match_count = Game.num_matches(fragment)
    if DICTIONARY.key?(fragment)
      return true if match_count == 1
      return true if rand(match_count).zero?
    end
    false
  end

  def self.valid_fragment?(fragment)
    DICTIONARY.each_key do |word|
      return true if word[0...fragment.length] == fragment
    end
    false
  end

  def self.get_guess(player)
    puts "#{player.name}, please choose a letter from A-Z:"
    player.valid_guess
  end

  def update_score(player)
    @scores[player.name] += 1
  end

  def score_to_text(score)
    LOSING_TEXT[0...score]
  end

  def show_bad_message(player)
    ghost_letter = LOSING_TEXT[@scores[player.name]]
    puts "Oh no, #{player.name} you’re getting a #{ghost_letter} of doom."
  end

  def self.show_good_message
    puts 'Good job! Fragment updated.'
  end

  def self.show_fragment(fragment)
    puts
    puts "Fragment: #{fragment}"
  end

  def update_players_list(player)
    if @scores[player.name] == LOSING_TEXT.length
      puts "Sorry #{player.name}, you're out!"
      @players.delete(player)
      return true
    end
    false
  end

  def winner?
    @players.length == 1
  end

  def show_winner
    puts "Congratulations #{@players[0].name}! YOU'RE THE WINNER!!"
    puts
  end

  def loser_sequence(turns)
    loser = @players[(turns - 2) % @players.length]
    show_bad_message(loser)
    update_score(loser)
    update_players_list(loser)
  end

  def show_scores
    puts '-----------------------------------------'
    puts 'SCOREBOARD:'
    @scores.each { |name, score| puts "#{name}: #{score_to_text(score)}" }
    puts '-----------------------------------------'
    puts
  end

  def word_complete(turns, player, fragment)
    puts
    puts "Word complete! Great job #{player.name}"
    puts "Final word is #{fragment}"
    puts
    loser_sequence(turns)
    puts
    sleep(3)
  end

  def round
    turns = 0
    fragment = ''
    fragment_updated = false

    Game.welcome_message

    until Game.fragment_is_word?(fragment) && fragment_updated
      Game.show_fragment(fragment)
      @fragment = fragment # for Ai Player
      turns = 0 if turns == players.length
      current_player = @players[turns]
      guess = Game.get_guess(current_player)
      if Game.valid_fragment?(fragment + guess)
        Game.show_good_message
        fragment += guess
        fragment_updated = true
      else
        show_bad_message(current_player)
        update_score(current_player)
        turns -= 1 if update_players_list(current_player)
        fragment_updated = false
      end
      return if winner?
      turns += 1
    end
    word_complete(turns, current_player, fragment)
  end

  def play
    until winner?
      round
      show_scores
    end
    show_winner
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new(3)
  #p game.players
  #game.round
  game.play
end