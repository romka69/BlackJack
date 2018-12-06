require_relative 'card'

class Deck
  CARD_VALS = %w[2 3 4 5 6 7 8 9 10 J Q K A]
  SUITS = %w[♤ ♡ ♧ ♢]

  attr_reader :deck

  def initialize
    @deck = create_deck
    @deck.shuffle!
  end

  def create_deck
    arr_handler = []

    CARD_VALS.each do |val|
      SUITS.each do |suit|
        arr_handler << Card.new(val, suit)
      end
    end

    arr_handler
  end

  def give_card
    @deck.pop
  end
end
