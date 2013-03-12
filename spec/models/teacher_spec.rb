require 'spec_helper'

describe Teacher do
	it { should have_many(:sections) }
		
	# context "scopes" do
	# 	it "should return current teachers" do
	# 		3.times {Fabricate(:teacher, current: true)}
	# 		2.times {Fabricate(:teacher, current: false)}
	# 		expect(Teacher.count).to eq 5
	# 		expect(Teacher.current.count).to eq 3
	# 	end
	# end
	# 
	
	context "Fabrication" do
    it "should produce a valid teacher" do
      expect(Fabricate(:teacher)).to be_valid
    end
    
    it "can create sections" do
      t = Fabricate :teacher, section_count: 3
      expect(t.sections.count).to eq 3
    end
      
	end

	context "courses" do
		before :each do
			@teacher = Fabricate(:teacher)
			course2 = Fabricate(:course, full_name: "Geometry Honors")
			course1 = Fabricate(:course, full_name: "Fractals")
			Fabricate(:section, teacher: @teacher, course: course1, block: "A")
			Fabricate(:section, teacher: @teacher, course: course1, block: "B")
			Fabricate(:section, teacher: @teacher, course: course2, block: "C")
			Fabricate(:section, teacher: @teacher, course: course2, block: "D")
		end
			
		describe '#courses' do
			it "should return the courses that a teacher is teaching" do
				expect(@teacher.courses.count).to eq 2
			end
		end
		
		describe '#course_names' do
			it "should return the names of the courses that a teacher is teaching" do
				expect(@teacher.course_names).to eq ["Fractals", "Geometry Honors"]
			end
		end
    
	end
	
end
