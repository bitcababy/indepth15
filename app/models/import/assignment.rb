class Import::Assignment < Import

	cattr_reader :mapping
	
	@@mapping = {
		"assgt_id" 							=> :orig_id,
		"teacher_id"						=> :teacher_id,
		"description"						=> :description,
		"kind"									=> :kind,
		"year"									=> :year,
		"name"									=> :name,
		}
		
	def self.gather_all_for_export
		self.where(:year.gte => 2011).desc(:year).all
	end
		
end
