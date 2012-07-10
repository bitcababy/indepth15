require 'active_support/concern'
require 'xmlsimple'

module ImportMassaged
	extend ActiveSupport::Concern
	
	module ClassMethods
		
		def to_real_class
			self.to_s.demodulize.tableize.singularize
		end

		def cleanup(hash)
			hash.each_pair do |k,v|
				v = v[0]
				v.delete("nil")
				hash[k] = 
				case 
				when v['type'] == 'boolean'
					(v == 'true')
				when v =~ /^\d+$/
					v.to_i
				when v == {"type" => "array"}
					v.delete("type")
					v["content"] || []
				when v['type'] == "datetime"
					v["content"]
					# DateTime.parse(v["content"])
				when v == {"nil" => true}
					nil
				else
					v
				end
			end
		end
	
		def path_for_class
			File.join(File.join(Rails.root, 'data'), "#{self.to_real_class.pluralize}.xml")
		end

		def import_to_array
			path = self.path_for_class
			::XmlSimple.xml_in(path,
					# 'NoAttr' => true,
			)
		end

		def load_from_data
			klass = ("::" + self.to_real_class.camelize).constantize
			self.delete_all
			klass.delete_all
			arr = self.import_to_array
			arr[self.to_real_class].each do |hash|
				cleanup(hash)
				if false
					puts hash
					puts "----\n"
				else
					klass.create! hash
				end
			end
		end
	end
end