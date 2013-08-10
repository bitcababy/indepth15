namespace :fix_durations do
  task :courses  => :environment do
    Course.each do |c|
      c.duration = Durations.old_to_new(c.duration)
      for section in c.sections
        section.duration = c.duration if section.duration.kind_of? Integer
        section.save!
      end
      c.duration = Durations::ONE_SEMESTER if c.duration == Durations::FIRST_SEMESTER || c.duration ==Durations::SECOND_SEMESTER
      c.save!
    end
  end
  task :sections => :environment do
    Section.each do |s|
      next if s.semester
      attrs = s.attributes
      next if attrs[:model_version] == Section::CURRENT_VERSION
      semester = s.duration
      semester  = Durations::FULL_YEAR if semester == Durations::FULL_YEAR_HALF_TIME
      new_s = Section.new teacher: s.teacher, course: s.course, model_version: Section::CURRENT_VERSION, block: s.block, semester: semester, year: s.year, room: s.room
      unless new_s.valid?
        puts "Invalid attributes: #{new_s.attributes}, #{s.to_param}"
        next
      end
      next if Section.where(_id: new_s._id).exists?
      begin
        new_s.save!
        s.section_assignments.each {|sa| sa.section = new_s; sa.save!}
        puts new_s.to_param if new_s.section_assignments.count == 0
        new_s.save!
        s.delete
      rescue
        puts s.to_param
        puts new_s.attributes
        break
      end
    end
    puts Section.count
    puts SectionAssignment.count
  end
end
