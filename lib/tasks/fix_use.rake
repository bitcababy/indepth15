task fix_use: :environment do
  filename = File.join(Rails.root, 'old_data', 'sa-use.txt')
  begin
    file = File.open(filename)
    oids = file.readlines
    for oid in oids do
      old_id = oid.to_i
      if SectionAssignment.where(old_id: old_id).exists?
         sa = SectionAssignment.find_by old_id: old_id
         sa.use = true
         sa.save
       end
     end
  ensure
    file.close
  end
  
  
end
