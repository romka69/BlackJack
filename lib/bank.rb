class Bank

  attr_reader :bank

  def initialize(val)
    @bank = val
  end

  def minus(val)
    @bank -= val
  end

  def plus(val)
    @bank += val
  end  
end
