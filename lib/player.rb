# Handle basic Player functions for Ghost: get valid name and input for game

class Player
  attr_reader :name
  def initialize(name)
    @name = Player.valid_name(name)
  end

  def self.valid_name(name)
    test_name = name
    while test_name == '' || test_name == 'AI Bot'
      puts 'Please enter a valid name.'
      test_name = gets.chomp
    end

    test_name.capitalize
  end

  def valid_guess
    str = gets.chomp.downcase
    while /^[a-z]$/.match(str).nil?
      puts 'Please enter a valid letter from A to Z.'
      str = gets.chomp.downcase
    end

    str
  end
end

if $PROGRAM_NAME == __FILE__
  player = Player.new('')
  puts player.name
  #p player.get_guess
end
