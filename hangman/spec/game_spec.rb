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

  end
end