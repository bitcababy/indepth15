class Pane
  attr_accessor :title, :div_id, :content

  def initialize(args={})
    @title = args[:title] || ""
    @div_id = args[:div_id] || ""
    return self
  end

end
