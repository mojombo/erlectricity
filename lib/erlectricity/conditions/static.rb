module Erlectricity
class StaticCondition < Condition
  attr_accessor :value
  def initialize(value)
    self.value = value
  end
  
  def satisfies?(arg)
    arg.eql? value
  end

end
end