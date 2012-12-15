class Assignment < TextDocument
	before_save :fix_content

	field :assgt_id, type: Integer
	validates :assgt_id, uniqueness: true
	
  has_many :section_assignments
  accepts_nested_attributes_for :section_assignments

	scope :dupes, ->(a) { where(:assgt_id.gt => a.assgt_id, :content => a.content) }

	index( {assgt_id: 1}, {unique: true})
	scope :with_assgt_id, ->(i) {where(assgt_it: i)}
	
	def fix_content
		self.content = Assignment.massage_content(self.content)
	end

	end

end
