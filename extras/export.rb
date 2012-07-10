require 'active_support/concern'
require 'xmlsimple'

module Export
	extend ActiveSupport::Concern
	
	module ClassMethods
		# def export_to_seed
		# 	path = File.join(File.join(Rails.root, 'data'), "seed.db")
		# 	begin
		# 		file = File.open(path,'w')
		# 		self.each do |obj|
		# 			export_one_to_seed(obj, file)
		# 		end
		# 	ensure
		# 		file.close()
		# 	end
		# end
		# 
		# def export_one_to_seed(obj)
		# 	res = ""
		# 	res += "\n#{self.to_s}.create!(\n"
		# 	obj.attributes.each_pair do |k,v|
		# 		res += "#{k}: #{v}\n"
		# 	end
		# 	res += ")\n"
		# 	return res
		# end
			
		def export_to_xml
			path = File.join(File.join(Rails.root, 'new_data'), "#{self.to_s.demodulize.tableize}.xml")
			begin
				file = File.open(path, "w")
				# self.each { | rec | file.write(rec.serializable_hash)}
				file.write(self.all.to_xml)
			rescue
			ensure
				file.close()
			end
		end
		
		
	end

end

