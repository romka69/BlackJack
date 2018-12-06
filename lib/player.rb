require_relative 'bank'
require_relative 'hand'

class Player
  BET = 10
  WIN_BET = BET * 2

  attr_reader :name, :bank, :hand

  def initialize(name)
    @name = name
    @bank = Bank.new(100)
    @hand = Hand.new
    validate!
  end

  def place_bet
    @bank.minus(BET)
  end

  def bet_back
    @bank.plus(BET)
  end

  def take_win_bet
    @bank.plus(WIN_BET)
  end

  def take_card(card)
    @hand.take_card(card)
  end

  def clear_hand
    @hand.clear_hand
  end

  def good_score?
    @hand.good_score?
  end

  def count_score
    @hand.count_score
  end

  def score
    @hand.score
  end

  def see_cards
    @hand.cards_in_line
  end

  def validate!
    raise "Имя не может быть пустым" if name.nil? || name.empty?
  end
end
