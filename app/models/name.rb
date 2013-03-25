class Name
  include Comparable
  attr_accessor :first, :middle, :last, :known_as, :honorific, :suffix
  
  def <=>(n)
    return self.last_name <=> u.last_name unless self.last_name == u.last_name
    return self.first_name <=> u.first_name unless self.first_name == u.first_name
    return self.middle_name <=> u.middle_name
   end

  def mongoize
    parms = [%i(first middle last known_as honorific suffix), [@first, @middle, @last, @known_as, @honorific, @suffix]].transpose
    return Hash[parms]
  end
  
  def to_full(omit_middle: true)
    if omit_middle
      return [@first, @last].compact.join(" ")
    else
      return [@first, @middle, @last].compact.join(" ")
    end
  end
      
  def to_formal
    return [self.honorifc, self.last].compact.join(" ")
  end

  class << self
    def demongoize(h)
      n = Name.new
      n.first = h[:first]
      n.middle = h[:middle]
      n.last = h[:last]
      n.known_as = h[:known_as]
      n.honorific = h[:honorific]
      n.suffix = h[:suffix]
      return n
    end
    
    alias from_hash demongoize
    
  end
  
end
