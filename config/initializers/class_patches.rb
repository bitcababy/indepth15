class Array
	alias contains? include?
end

class Set 
  def mongoize
    self.to_a
  end
  
  class << self
    def demongoize(obj)
      Set.new obj
    end
    
    def mongoize(obj)
      case obj
      when Set then obj.mongoize
      else obj
      end
    end
    
    def evolve(obj)
      case object
      when Set then obj.mongoize
      else obj
      end
    end
  end
end

class SortedSet 
  def mongoize
    self.to_a
  end

  class << self
    def demongoize(obj)
      SortedSet.new obj
    end
    
    def mongoize(obj)
      case obj
      when SortedSet then obj.mongoize
      when Set then obj.mongoize
      else obj
      end
    end
    
    # def evolve(obj)
    #   case object
    #   when SortedSet then obj.mongoize
    #   else obj
    #   end
    # end
  end
end

  
