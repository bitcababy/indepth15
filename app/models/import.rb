require 'xmlsimple'

class Import
	include Mongoid::Document
	
	
	class << self
		@conversions = {
			/^\d+$/ => lambda{|s| s.to_i},
			/^null$/ => nil,
			/^NULL$/ => nil,
			/^true$/ => true,
			/^false$/ => false,
		}

		def massage_hash(hash)
			hash
		end

		def import_and_create(name=nil)
			name ||= self.to_s.demodulize.tableize
			arr = import_file "#{name}.xml"
			create_imported_records(arr.collect {|a| flatten(a)})
		end

		def import_file(name)
			path = File.join(File.join(Rails.root, 'old_data'), name)
			imported = ::XmlSimple.xml_in(path,
					'KeyToSymbol' => true,
					'GroupTags' => {
					},
					:conversions => @conversions,
					"KeyAttr" => ['database'],
					'ForceArray' => false,
			)
			imported[:database][:table].collect {|h| h[:column]}
			# self.flatten(res.collect {|item| item[:column]})
		end
	
		def flatten(arr)
			map = self.mapping
			arr.inject({}) do |memo, pair|
				k = pair['name']
				v = pair[:content]

				if map[k] then
					k = map[k] || k
					v = pair[:content]
					if v then
						v = case 
						when v =~ /^\d+$/
							v.to_i
						when v == "NULL"
							nil
						when v == "false"
							false
						when v == "true"
							false
						else
							v
						end
					end
					memo[k] = v
				end
				memo
			end
		end

		def create_imported_records(arr)
			self.delete_all
			for a in arr do
				create_imported_record(a)
			end
		end

		def create_imported_record(hash)
			# puts hash
			self.create! hash
		end

		def squash_values(a)
			a.inject({}) {|memo, obj| memo.merge(obj)}
		end

		def gather_all_for_export
			self.all
		end
			
		def export_to_xml
			path = File.join(File.join(Rails.root, 'data'), "#{self.to_s.demodulize.tableize}.xml")
			res = gather_all_for_export.to_xml
			begin
				res.gsub!(/import-([^>]+)>/) { |match| "#{$1}>" }
				
				file = File.open(path, "w")
				file.write(res)
			rescue Exception
				STDERR.puts "export_to_xml failed, #{$!}"
			ensure
				file.close()
			end
		end

		def to_real_class
			self.to_s.demodulize.tableize.singularize
		end

		def cleanup(hash)
			hash.inject({}) do |memo, pair|
				k = pair[0]
				v = pair[1]
				k = k.gsub('-', '_') 
				if v.kind_of? Hash and !v.empty? then
					v.delete("nil")
					v = 
					case v['type']
					when 'boolean'
						(v['content'] == 'true')
					when 'integer'
						v['content'].to_i
					when 'array'
						v["content"] || []
					else
						v["content"]
					end
				end
				memo[k] = v
				memo
			end
		end

		def path_for_class
			File.join(File.join(Rails.root, 'data'), "#{self.to_real_class.pluralize}.xml")
		end

		def import_to_array
			path = self.path_for_class
			::XmlSimple.xml_in(path,
					'ForceArray' => false,
					:conversions => @conversions,
			)
		end

		def load_from_data
			klass = ("::" + self.to_real_class.camelize).constantize
			self.delete_all
			klass.delete_all
			arr = self.import_to_array
			arr[self.to_real_class.dasherize].each do |hash|
				new_hash = cleanup(hash)
				if false
					puts new_hash
					puts "----\n"
				else
					klass.convert_record(new_hash)
				end
			end
		end
		
	end
	
end
