task :fix_asst_names => :environment do
  Assignment.each do |asst|
    if asst.name =~ /^\d+$/
      asst.name = asst.name.to_i
      puts asst.name
      asst.save
    end
  end
end
