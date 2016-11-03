require "benchmark"

module Hangman
  
  # Represents the hangman game
  class Game
    attr_reader :secret_word, :dictionary

    def initialize(name)
      @player = Player.new(name)
      @dictionary = File.readlines("5desk.txt").each(&:strip!)
    end

    # Starts a new game of hangman
    def play
      instructions
      @secret_word = make_secret_word
      @board = Board.new(@secret_word)
    end

    # Displays the instructions for the game
    def instructions
    end

    # Returns a randomly selected word between 5 and 12  
    # characters long from the dictionary
    def make_secret_word
      word = @dictionary.sample
      until word.length.between?(5,12)
        word = @dictionary.sample
      end
      word
    end

  end

end
