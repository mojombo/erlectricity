module Erlectricity
class Matcher
  attr_accessor :condition, :block
  attr_accessor :receiver
  
  def initialize(parent, condition, block)
    self.receiver = parent
    @block = block
    @condition = condition
  end
  
  def run(arg)
    args = get_bound arg
    block.call *args
  end
  
  def matches?(arg)
    if @condition.is_a?(Array)
      return false unless arg.is_a?(Array)
      return false if @condition.length != arg.length
      @condition.zip(arg).all?{|l,r| l.satisfies?(r)}
    else
      @condition.satisfies?(arg)
    end
  end
  

  private
  
  def get_bound(arg)
    if @condition.is_a?(Array) && arg.is_a?(Array)
      @condition.zip(arg).map{|l,r| l.binding_for r}.compact
    else
      @condition.binding_for(arg)
    end
  end
end
end