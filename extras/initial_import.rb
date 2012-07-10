require 'xmlsimple'

module InitialImport
	def import_and_create
		arr = import_file "#{self.to_s.demodulize.tableize}.xml"
		create_imported_records(arr)
	end

	def import_file(name)
		path = File.join(File.join(Rails.root, 'old_data'), name)
		imported = ::XmlSimple.xml_in(path,
				'KeyToSymbol' => true,
				'GroupTags' => {
					'database' => {'table' => 'column'},
				},
				# :conversions => {
				# 	/"[0-9]+"/ => lambda { |n| n.to_i},
				# 	/"NULL"/ => nil
				# },
			"KeyAttr" => ['database'],
		)
		res = imported[:database][0][:table]
		self.flatten(res.collect {|item| item[:column]})
	end
	
	def flatten(arr)
		map = self.mapping
		arr.collect do |a|
			res = {}
			a.collect do |h|
				k = map[h["name"]] || k
				v = h[:content]
				res[k] = v[0] if v
			end
			res
		end
	end

	def create_imported_records(arr)
		self.delete_all
		for a in arr do
			create_imported_record(a)
		end
	end
	
	def create_imported_record(hash)
		hash[:orig_id] = hash['id']
		hash.delete('id')
		self.create! hash
	end

	def squash_values(a)
		a.inject({}) {|memo, obj| memo.merge(obj)}
	end

end
