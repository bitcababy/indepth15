namespace :sections do
  task :update => :environment do
    Section.each do |s|
      if s.model_version == 2
        s.remove_attribute :du
        s.save!
        puts s.attributes
        puts '*'
        next
      end

      attrs = s.attributes
      attrs.delete(:duration)
      attrs[:semester] = s.course.duration
      attrs[:model_version] = 2
      new_s = Section.new attrs
      if Section.where(_id: new_s._id).exists?
        s.delete!
        next
      end

      # puts new_s.attributes
      new_s.section_assignments.each {|sa| sa.section = new_s}
      begin
        new_s.save!
      rescue
        puts new_s.attributes
        next
      end
      s.delete
      puts '.'
    end
  end

end
