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

	context "courses & sections" do
		before do
			@teacher = Fabricate(:teacher)
			c1 = Fabricate(:course, full_name: "Geometry Honors", teacher: @teacher)
			c2 = Fabricate(:course, full_name: "Fractals", teacher: @teacher)
      3.times {Fabricate :section, course: c1, teacher: @teacher }
      2.times {Fabricate :section, course: c2, teacher: @teacher }
      6.times {Fabricate :section_earlier_year, course: c1, teacher: @teacher }
		end
    
    describe 'sections.current' do
      it "should return all sections taught this year" do
        expect(@teacher.sections.count).to eq 11
        expect(@teacher.sections.current.count).to eq 5
      end
    end
 			
		describe '#courses' do
			it "should return the courses that a teacher is teaching" do
				expect(@teacher.courses.count).to eq 2
			end
		end
    
    describe 'courses.current' do
      it "should return the courses that a teacher is teaching this year" do
        expect(@teacher.courses.current.count).to eq 2
      end
    end
		
		describe '#course_names' do
			it "should return the names of the courses that a teacher is teaching" do
				expect(@teacher.course_names).to eq ["Fractals", "Geometry Honors"]
			end
		end
    
	end
	
end
