class ObjPane < Pane
  def initialize(args={})
    @obj = args[:object]
    return super
  end
  
  def content
    @obj.content
  end
  
  def content=(cnt)
    @obj.content = cnt
  end

end
