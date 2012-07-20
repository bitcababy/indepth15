require 'action_view/helpers/url_helper'

class MenuItem
  include Mongoid::Document
	include ActionView::Helpers::UrlHelper

	field :or, as: :order, type: Integer, default: 0
	field :co, as: :controller, type: Symbol
	field :ac, as: :action, type: Symbol
	field :la, as: :label, type: String
	field :li, as: :link, type: String
	field :sh, as: :show, type: Boolean, default: true
	field :ii, as: :item_id, type: String, default: ''
	field :ic, as: :item_class, type: String, default: ''
	field :tag, type: String

	belongs_to :object, polymorphic: true

	recursively_embeds_many
	
	def menu_label
		return self.label if self.label
		return self.object.menu_label if self.object
		raise "Object missing label"
	end
	
	def to_s
		return self.label
	end
	
end
