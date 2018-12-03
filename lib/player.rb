require_relative 'bank'

class Player
  VAL_BET = 10
  VAL_WIN_BET = VAL_BET * 2

  attr_accessor :score
  attr_reader :name, :bank, :hand

  def initialize(name)
    @name = name
    @bank = Bank.new(100)
    @hand = []
    @score = 0
    validate!
  end

  def place_bet
    @bank.minus(VAL_BET)
  end

  def bet_back
    @bank.plus(VAL_BET)
  end

  def take_win_bet
    @bank.plus(VAL_WIN_BET)
  end

  def take_card(card)
    @hand << card
  end

  def clear_hand
    @hand = []
  end

  def add_card?
    return true if @hand.size < 3
  end

  def good_score?
    return true if @score < 22
  end

  def validate!
    raise "Имя не может быть пустым" if name.nil? || name.empty?
  end
end
