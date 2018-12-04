class Hand
  attr_reader :cards, :score

  def initialize
    @cards = []
    @score = 0
  end

  def take_card(card)
    @cards << card
  end

  def clear_hand
    @cards = []
  end

  def add_card?
    return true if @cards.size < 3
  end

  def cards_in_line
    cards = []
    @cards.each { |card| cards << [card.val + card.suit] }
    cards.join(', ')
  end

  def count_score
    score = 0
    ace = false

    @cards.each do |card|
      score += card.score_card
      ace = true if card.ace?
    end

    score -= 10 if ace == true && score > 21
    @score = score
  end

  def good_score?
    return true if @score < 22
  end
end
