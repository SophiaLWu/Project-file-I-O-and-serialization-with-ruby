require "benchmark"

module Hangman
  
  # Represents the hangman game
  class Game
    attr_reader :secret_word, :dictionary, :board

    def initialize(name)
      @player = Player.new(name)
      @dictionary = File.readlines("5desk.txt").each(&:strip!)
      @guesses_left = 8
      @win = false
    end

    # Starts a new game of hangman
    def play
      instructions
      create_game

      until @guesses_left == 0 || @win || win?
        puts "\n" << "=" * 70 << "\n\n"
        take_turn
        @guesses_left -= 1
      end

      @win = win? # Check for a win at the last guess
      display_ending_screen
    end

    # Creates a secret word and a board
    def create_game
      @secret_word = make_secret_word
      @board = Board.new(@secret_word)
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
      puts "-You have 8 guesses to try and figure out the secret word."
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

    # Prints the ending screen of the game
    def display_ending_screen
      puts "\n" << "=" * 70 << "\n\n"
      @board.display_guess
      puts "\nThe secret word was: #{@secret_word}\n\n"

      if @win
        puts "YOU WIN!"
        puts "Congratulations! You guessed the word."
      else
        puts "YOU LOSE."
        puts "Sorry, you couldn't guess the word."
      end
    end

    # Sets @win to true if the player word guess is correct and
    # returns a string indicating if the guess was correct or not
    def check_word_guess(guess)
      if guess.downcase == @secret_word
          @win = true
          @board.finish_guess
          "\nYour word guess was correct!" 
      else
        "\nYour word guess was incorrect." 
      end
    end

    # Returns true if string contains only letters
    def contains_only_letters?(input)
      /[^A-Za-z]/ !~ input
    end

    # Returns true if the player input is valid (word guess only)
    def valid_word_input?(guess)
      guess.length == @secret_word.length && contains_only_letters?(guess)
    end

    # Returns true if the player input is valid (not counting word guesses)
    def valid_letter_input?(guess)
      guess.length == 1 && contains_only_letters?(guess) &&
      !@board.guessed_letters.include?(guess)
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
