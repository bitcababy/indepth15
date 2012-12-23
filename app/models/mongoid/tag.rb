class Mongoid::Tag
  include Mongoid::Document

  field :name, type: String
  validates :name, presence: true, length: { minimum: 0, maximum: 128 }, uniqueness: true

  def self.named(n)
    where(name: match_exact(n))
  end
  
  def self.named_any(list)
    matches = list.map {|item| match_exact(item)}
    matches = matches.map { |item| Regexp.new(item, Regexp::IGNORECASE) }
    self.in(name: matches)
  end
    
  def self.named_like(n)
    where(name: match_like(n))
  end
  
  def self.named_like_any(list)
    matches = list.map {|item| match_like(item)}
    self.in(name: matches)
  end
  
  def self.find_or_create_with_like_by_name(s)
    res = named_like(s)
    return (res.count == 0 ) ? create!(name: s) : res.first
  end
  
  def self.find_or_create_all_with_like_by_name(*list)
    list = [list].flatten

    return [] if list.empty?

    existing_tags = self.named_any(list).to_a
  
    new_tag_names = list.reject do |name|
                        name = comparable_name(name)
                        existing_tags.any? { |tag| comparable_name(tag.name) == name }
                      end
    created_tags  = new_tag_names.map { |name| self.create(name: name) }
    existing_tags + created_tags
  end
    
  def ==(object)
    super || (object.kind_of?(Mongoid::Tag) && name == object.name)
  end

  def to_s
    name
  end

  # def self.named_like_any(list)
  #   match = list.map {|item| '*' + Regexp.escape(item) + '*'}
  #   match = match.map { |item| Regexp.new(item, Regexp::IGNORECASE) }
  #   self.in(name: match)
  # end
  # 
  
  class << self
    private
    def comparable_name(str)
      str.mb_chars.downcase.to_s
    end
  end

 protected
  
  def self.match_exact(s)
    return Regexp.new('^' + Regexp.escape(s) + '$', Regexp::IGNORECASE)
  end
    
  def self.match_like(s)
    return Regexp.new('.*' + Regexp.escape(s) + '.*', Regexp::IGNORECASE)
  end
  
  
    
end
