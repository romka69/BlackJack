require_relative 'player'

class Dealer < Player
  WARNING_SCORE = 17

  def add_card?
    return true if @hand.score < WARNING_SCORE && @hand.add_card?
  end
end
