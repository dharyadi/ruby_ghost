# Handle basic Player functions for Ghost: get valid name and input for game

class Player
  attr_reader :name
  def initialize(name)
    @name = Player.valid_name(name)
  end

  def self.valid_name(name)
    test_name = name
    while test_name == ''
      puts 'Please enter a valid name.'
      test_name = gets.chomp
    end

    test_name.capitalize
  end

  def self.guess(str)
    letter = str.to_s
    while /[a-zA-z]/.match(letter) == nil || letter.length != 1
      puts 'Please enter a valid letter from A to Z.'
      letter = gets.chomp
    end

    letter.downcase
  end
end

if $PROGRAM_NAME == __FILE__
  player = Player.new('')
  puts player.name
  #player.guess(1)
  #player.guess('i')
end
