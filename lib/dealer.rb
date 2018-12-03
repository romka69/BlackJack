require_relative 'player'

class Dealer < Player
  WARNING_SCORE = 17

  def add_card?
    return true if @score < WARNING_SCORE && @hand.size < 3
  end
end
