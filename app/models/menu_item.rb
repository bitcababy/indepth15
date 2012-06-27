class MenuItem
  include Mongoid::Document
	field :o, as: :order, type: Integer
	field :l, as: :link, type: String

	recursively_embeds_many
	belongs_to :obj, polymorphic: true
	
	def text
		obj ? obj.to_menu_item : ""
	end
	
	def root?
		self.parent_menu_item.nil?
	end

end
