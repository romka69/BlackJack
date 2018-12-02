require_relative 'bank'

class Player

  VAL_BET = 10
  VAL_WIN_BET = 20

  attr_reader :name, :bank, :hand

  def initialize(name)
    @name = name
    @bank = Bank.new(100)
    @hand = []
  end

  def place_bet
    @bank.minus(VAL_BET)
  end
  
  def get_win_bet
    @bank.plus(VAL_WIN_BET)
  end

  def take_card(card)
    @hand << card
  end

  def clear_hand
    @hand = []
  end
end
