module Hangman
  
  # Represents the hangman "board", i.e. the word, number of guesses left
  class Board
    attr_reader :guessed_letters, :guess, :secret_word_letters

    def initialize(secret_word)
      @secret_word = secret_word
      @secret_word_letters = word_as_array # Secret word as an array
      @guess = create_guess
      @guessed_letters = []
    end

    # Displays the board to the plauer
    def display_board
      puts @guess.join(" ")
      puts "Guessed letters: #{@guessed_letters.join(" ")}"
    end

    # Given a letter guess from the player:
    # => adds letter to @guessed_letters (list of all guessed letters)
    # => if letter guess is correct, changes @letters and @guess accordingly
    def add_letter_guess(letter)
      @guessed_letters << letter
      while @secret_word_letters.include? letter
        index = @secret_word_letters.index letter
        @secret_word_letters[index] = "guessed"
        @guess[index] = letter
      end
    end

    # Initially creates a new displayed guess as a string
    # with only "_" in the string
    def create_guess
      Array.new(@secret_word.length, "_")
    end

    def word_as_array
      @secret_word.split("")
    end

  end

end
