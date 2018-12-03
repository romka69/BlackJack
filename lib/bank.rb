class Bank
  attr_reader :quantity

  def initialize(val)
    @quantity = val
  end

  def minus(val)
    @quantity -= val
  end

  def plus(val)
    @quantity += val
  end
end
