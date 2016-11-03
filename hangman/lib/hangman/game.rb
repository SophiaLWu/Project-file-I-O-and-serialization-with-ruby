require "benchmark"

module Hangman
  
  # Represents the hangman game
  class Game
    attr_reader :secret_word, :dictionary

    def initialize(name)
      @player = Player.new(name)
      @dictionary = File.readlines("5desk.txt").each(&:strip!)
      @guesses_left = 15
      @win = false
    end

    # Starts a new game of hangman
    def play
      instructions
      @secret_word = make_secret_word
      @board = Board.new(@secret_word)

      until @guesses_left == 0 || @win || win?
        puts "\n" << "=" * 70 << "\n\n"
        take_turn
        @guesses_left -= 1
      end

      puts "\n" << "=" * 70 << "\n\n"
      @board.display_guess
      puts "\nThe secret word was: #{@secret_word}"
    end

    # Displays the instructions for the game
    def instructions
      puts "\nHello! Welcome to Hangman!\n\n"
      puts "-The object of the game is to guess the computer's secret word."
      puts "-Each turn, you will guess a letter that you think is in the word."
      puts "-If the letter is in the word, then that letter will be revealed "
      puts "in the secret word (multiple copies as well)."
      puts "-At any time, you can try and guess the full secret word if you "
      puts "think you know it."
      puts "-You have 6 guesses to try and figure out the secret word."
      puts "\nGood luck!"
    end

    # Allows player to take one turn and performs manipulations on the board
    def take_turn
      @board.display_board
      puts "\nGuesses left: #{@guesses_left}"
      puts "\nWhat is your guess?"
      print ">> "
      guess = gets.chomp

      until valid_letter_input?(guess) || valid_word_input?(guess)
        puts "Invalid input! Please input an unused letter or full "\
             "guess for the word."
        print ">> "
        guess = gets.chomp
      end

      if valid_word_input?(guess)
        puts check_word_guess(guess)
        return
      end

      @board.add_letter_guess(guess)

      puts print_guess_correct_or_not
    end

    # Sets @win to true if the player word guess is correct and
    # returns a string indicating if the guess was correct or not
    def check_word_guess(guess)
      if guess.downcase == @secret_word
          @win = true
          "\nYour word guess was correct!" 
      else
        "\nYour word guess was incorrect." 
      end
    end

    # Returns true if the player input is valid (word guess only)
    def valid_word_input?(guess)
      guess.length == @secret_word.length
    end

    # Returns true if the player input is valid (not counting word guesses)
    def valid_letter_input?(guess)
      guess.length == 1 && !@board.guessed_letters.include?(guess)
    end

    # Returns a corresponding string if the guess was correct or not
    def print_guess_correct_or_not
      if @board.correct_current_guess == true
        "\nYour letter guess was correct!" 
      else
        "\nYour letter guess was incorrect." 
      end
    end

    # Returns true if player has guessed all the letters in the secret word
    def win?
      @board.guess.none? { |letter| letter == "_" }
    end

    # Returns a randomly selected word between 5 and 12  
    # characters long from the dictionary
    def make_secret_word
      word = @dictionary.sample
      until word.length.between?(5,12)
        word = @dictionary.sample
      end
      word.downcase
    end

  end

end
