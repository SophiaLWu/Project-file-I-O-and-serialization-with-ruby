require "spec_helper"

module Hangman
  describe Game do

    context "#initialize" do
      it "raises an error when initialized without arguments" do
        expect { Game.new }.to raise_error(ArgumentError)
      end

      it "does not raise an error when initialized with a player name" do
        expect { Game.new("Ashley") }.to_not raise_error
      end
    end

    context "#make_secret_word" do
      it "returns a random word that is between 5-12 characters long" do
        g = Game.new("Ashley")
        sample_words = []
        1000.times do
            sample_words << g.make_secret_word
        end
        correct = sample_words.all? { |word| word.length.between?(5,12) }
        expect(correct).to eq(true)
      end
    end

    context "#win" do
      it "returns true if the player has guessed all letters in the word" do
        g = Game.new("Ashley")
        g.create_game
        letters = g.secret_word.split("").uniq
        letters.each do |letter|
            g.board.add_letter_guess(letter)
        end
        expect(g.win?).to eq(true)
      end

      it "returns false if the player hasn't guessed all letters in the word" do
        g = Game.new("Ashley")
        g.create_game
        expect(g.win?).to eq(false)
      end
    end

    context "#print_guess_correct_or_not" do
      it "returns 'Your letter guess was correct!' when letter guess "\
         "is correct" do
        g = Game.new("Ashley")
        g.create_game
        letters = g.secret_word.split("").uniq
        g.board.add_letter_guess(letters[0])
        correct_string = "\nYour letter guess was correct!"
        expect(g.print_guess_correct_or_not).to eq(correct_string)
      end

      it "returns 'Your letter guess was incorrect.' when letter guess "\
        "is incorrect" do
        g = Game.new("Ashley")
        g.create_game
        correct_string = "\nYour letter guess was incorrect."
        expect(g.print_guess_correct_or_not).to eq(correct_string)
      end
    end

    context "#valid_letter_input?" do
    end

  end
end