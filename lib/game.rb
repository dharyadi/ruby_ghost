# All game functions for turns, rounds, wins, losses
require_relative './player.rb'

class Game
  attr_reader :players, :LOSING_TEXT
  MIN_PLAYERS = 2
  MAX_PLAYERS = 4
  DICTIONARY = File.read('dictionary.txt').split(/\n+/).product([nil]).to_h
  LOSING_TEXT = 'GHOST'.freeze

  def initialize(num_players)
    num_players = validate_num_players(num_players)
    @players = []
    create_players(num_players)
  end

  def validate_num_players(num_players)
    while !(MIN_PLAYERS..MAX_PLAYERS).include?(num_players)
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
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new(3)
  p game.players
end