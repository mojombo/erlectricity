module Erlectricity
  class Condition
  
    def initialize
    end
  
    def binding_for(arg)
      nil
    end
  
    def satisfies?(arg)
      false
    end
    
    alias === satisfies?
  end

  module Conditions
    def atom()
      TypeCondition.new(Symbol)
    end
  
    def any()
      TypeCondition.new(Object)
    end
  
    def number()
      TypeCondition.new(Fixnum)
    end
  
    def pid()
      TypeCondition.new(Erlectricity::Pid)
    end
  
    def string()
      TypeCondition.new(String)   
    end
  
    def list()
      TypeCondition.new(Array) 
    end
  
    def hash()
      HashCondition.new()
    end
  end
  
  extend Conditions
end

Any = Object