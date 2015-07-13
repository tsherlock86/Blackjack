
require_relative 'Card'

class Deck
  attr_accessor :cards

  def initialize
    suit = %w(Hearts Diamonds Spades Clubs)
    value = (2..10).to_a
    @cards = []
    suit.each do |suit|
      value.each do |value|

        @cards << Card.new(suit, value, value)
      end
        @cards << Card.new(suit,10, "Jack")
        @cards << Card.new(suit,10, "Queen")
        @cards << Card.new(suit,10, "King")
        @cards << Card.new(suit,11, "Ace")
    end
  shuffle!
  end

  def shuffle!
      self.cards.shuffle!
    end
end
