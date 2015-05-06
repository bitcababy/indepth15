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
      expect(Fabricate.build(:teacher)).to be_valid
    end
    
    it "can create sections" do
      t = Fabricate :teacher, section_count: 3
      expect(t.sections.count).to eq 3
    end
	end

	context "courses & sections" do
		before do
			@teacher = Fabricate(:teacher)
			c1 = Fabricate(:course, full_name: "Geometry Honors", teacher: @teacher, num_sections: 2)
			Fabricate(:course, full_name: "Fractals", teacher: @teacher, num_sections: 2)
      2.times { Fabricate :section, course: c1, teacher: @teacher, year: Settings.academic_year - 2 }
      expect(@teacher.sections.count).to eq 6
		end
    
    describe 'sections.current' do
      it "should return all sections taught this year" do
        expect(@teacher.sections.current.count).to eq 4
      end
    end
 			
		describe '#courses' do
			it "should return the courses that a teacher is teaching" do
				expect(@teacher.courses(all: true).count).to eq 2
			end
		end
    
    describe 'current courses' do
      it "should return the courses that a teacher is teaching this year" do
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
