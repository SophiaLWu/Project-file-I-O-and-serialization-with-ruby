require "spec_helper"

module Hangman
  describe Board do

    context "#initialize" do
      it "raises an error when initialized without arguments" do
        expect { Board.new }.to raise_error(ArgumentError)
      end

      it "does not raise an error when initialized with a secret word" do
        expect { Board.new("belligerent") }.to_not raise_error
      end
    end

    context "#add_letter_guess" do
      it "adds the player's new guess to @guessed_letters array" do
        b = Board.new("canonical")
        b.add_letter_guess("a")
        expect(b.guessed_letters).to eq(["a"])
      end

      it "adds multiple player guesses to @guessed_letters array" do
        b = Board.new("canonical")
        b.add_letter_guess("a")
        b.add_letter_guess("c")
        b.add_letter_guess("n")
        b.add_letter_guess("x")
        expect(b.guessed_letters).to eq(%w{a c n x})
      end

      it "updates the guess array if the player letter guess is correct" do
        b = Board.new("canonical")
        b.add_letter_guess("i")
        expect(b.guess).to eq(%w{_ _ _ _ _ i _ _ _})
      end

      it "updates the secret_word_letters array if the player letter guess "\
         "is correct" do
        b = Board.new("canonical")
        b.add_letter_guess("i")
        expect(b.secret_word_letters).to eq(%w{c a n o n guessed c a l})
      end

      it "doesn't update the guess array if the player letter guess is wrong" do
        b = Board.new("canonical")
        b.add_letter_guess("x")
        expect(b.guess).to eq(%w{_ _ _ _ _ _ _ _ _})
      end

      it "doesn't update the secret_word_letters array if the player letter "\
         "guess is wrong" do
        b = Board.new("canonical")
        b.add_letter_guess("x")
        expect(b.secret_word_letters).to eq(%w{c a n o n i c a l})
      end

      it "updates the guess array if the player letter guess is correct "\
         "and there are multiple copies of the letter in the word" do
        b = Board.new("canonical")
        b.add_letter_guess("a")
        expect(b.guess).to eq(%w{_ a _ _ _ _ _ a _})
      end

      it "updates the secret_word_letters array if the player letter guess "\
         "is correct and there are multiple copies of the letter in the word" do
        b = Board.new("canonical")
        b.add_letter_guess("a")
        expect(b.secret_word_letters).to eq(%w{c guessed n o n i c guessed l})
      end

      it "updates the guess array after multiple player letter guesses" do
        b = Board.new("canonical")
        b.add_letter_guess("a")
        b.add_letter_guess("x")
        b.add_letter_guess("c")
        b.add_letter_guess("n")
        expect(b.guess).to eq(%w{c a n _ n _ c a _})
      end

      it "updates the secret_word_letters array after multiple player "\
         "letter guesses" do
        b = Board.new("canonical")
        b.add_letter_guess("a")
        b.add_letter_guess("x")
        b.add_letter_guess("c")
        b.add_letter_guess("n")
        expect(b.secret_word_letters).to eq(\
          %w{guessed guessed guessed o guessed i guessed guessed l})
      end
    end

    context "#create_guess" do
      it "returns a new array with x underscores, where x is the length "\
         "of the secret word" do
        b = Board.new("hello")
        expect(b.create_guess).to eq(%w{_ _ _ _ _})
      end
    end

    context "#word_as_array" do
      it "returns the word split into an array" do
        b = Board.new("belligerent")
        expect(b.word_as_array).to eq(%w{b e l l i g e r e n t})
      end
    end

  end
end