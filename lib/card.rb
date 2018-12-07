class Card
  attr_reader :val, :suit

  def initialize(val, suit)
    @val = val
    @suit = suit
  end

  def score_card
    return 10 if %w[J Q K].include?(@val)
    return 11 if 'A'.include?(@val)
    return @val.to_i if @val.to_i
  end

  def ace?
    return true if 'A'.include?(@val)
  end
end
