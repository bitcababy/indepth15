require 'spec_helper'

describe SectionAssignment do
  context "Fabrication" do
    it "should be valid" do
      expect(Fabricate.build :section_assignment).to be_valid
    end

    it "should have associated records" do
      sa = Fabricate :section_assignment
      expect(sa.section).to_not be_nil
      expect(sa.section.course).to_not be_nil
      expect(sa.assignment).to_not be_nil
      expect(sa.assignment.name).to_not be_nil
      expect(sa.section.section_assignments).to include sa
    end
    
    it "should be able to create past sas" do
      expect(Fabricate(:section_assignment_past).due_date).to be < Date.today
    end
    
    # it "should be able to specify a teacher" do
    #   teacher = Fabricate :teacher
    #   sa = Fabricate :section_assignment, teacher: teacher
    #   expect(sa.section.teacher).to eq teacher
    # end
    # it "should be able to specify a course" do
    #   course = Fabricate :course
    #   sa = Fabricate :section_assignment, course: course
    #   expect(sa.section.course).to eq course
    # end
    # it "should be able to specify a year" do
    #   sa = Fabricate :section_assignment, year: Settings.academic_year - 1
    #   expect(sa.section.year).to eq Settings.academic_year - 1
    # end
    
  end
  
  subject { Fabricate :section_assignment }
  
  it "syncs itself with its section before creation" do
    s = Fabricate :section
    sa = Fabricate.build :section_assignment, section: s
    sa.save
    expect(sa.block).to eq s.block
    expect(sa.year).to eq s.year
    expect(sa.course).to eq s.course
    expect(sa.teacher).to eq s.teacher
  end
      
	context "scoping" do
		before :each do
			@section = Fabricate :section, block: "B"
			3.times {|i| Fabricate :section_assignment_future, section: @section }
			4.times {|i| Fabricate :section_assignment_past, section: @section }
		end
    
    it "has a 'for_section' scope" do
      expect(SectionAssignment.for_section(@section).count).to eq 7
    end
    
    # it "has a 'for_year' scope" do
    #   sa = Fabricate :section_assignment, section: Fabricate(:section, year: (Settings.academic_year - 2))
    #   expect(SectionAssignment.for_year(Settings.academic_year).count).to eq 7
    # end
    # 
    it "has a due_after scope" do
      expect(@section.section_assignments.due_after(Date.today).to_a.count).to eq 3
    end
    
    it "has a 'due_on_or_after' scope" do
      expect(@section.section_assignments.due_on_or_after(Date.today).to_a.count).to eq 3
    end
      
    it "has a 'due_after' scope" do
      expect(@section.section_assignments.due_after(Date.today).to_a.count).to eq 3
    end

		it "has a future scope" do
			expect(SectionAssignment.for_section(@section).future.to_a.count).to eq 3
		end
		
		it "has a past scope" do
			expect(SectionAssignment.past.to_a.count).to eq 4
		end
		
		it "has a next_assignment scope" do
			expect(SectionAssignment.next_assignment.to_a.count).to eq 1
		end

		it "has an upcoming scope" do
			expect(SectionAssignment.upcoming.to_a.count).to eq 2
		end
		
	end
	
  describe "#filter_by" do
    it "should be able to filter by teacher" do
      t1 = Fabricate(:teacher)
      t2 = Fabricate(:teacher)
      s1 = Fabricate :section, teacher: t1
      s2 = Fabricate :section, teacher: t2
      2.times { Fabricate :section_assignment, section: s1 }
      3.times { Fabricate :section_assignment, section: s2 }
      SectionAssignment.each do |sa|
        expect(sa.teacher).to_not be_nil
      end
      expect(SectionAssignment.filter_by(teacher: t1).count).to eq 2
    end
    
    it "should be able to filter by course" do
      c1 = Fabricate(:course)
      c2 = Fabricate(:course)
      s1 = Fabricate :section, course: c1
      s2 = Fabricate :section, course: c2
      2.times { Fabricate :section_assignment, section: s1 }
      3.times { Fabricate :section_assignment, section: s2 }
      expect(SectionAssignment.filter_by(course: c1).count).to eq 2
    end
    
    it "should be able to filter by teacher and course" do
      t1 = Fabricate(:teacher)
      t2 = Fabricate(:teacher)
      c1 = Fabricate(:course)
      c2 = Fabricate(:course)
      s11 = Fabricate :section, course: c1, teacher: t1
      s12 = Fabricate :section, course: c1, teacher: t2
      s21 = Fabricate :section, course: c2, teacher: t1
      s22 = Fabricate :section, course: c2, teacher: t2
      
      2.times { Fabricate :section_assignment, section: s11 }
      3.times { Fabricate :section_assignment, section: s12 }
      4.times { Fabricate :section_assignment, section: s21 }
      8.times { Fabricate :section_assignment, section: s21 }
      expect(SectionAssignment.filter_by(course: c1, teacher: t1).count).to eq 2
    end
            
    it "should be able to filter by year" do
      s1 = Fabricate :section, year: 2003
      s2 = Fabricate :section, year: 2004
      2.times { Fabricate :section_assignment, section: s1 }
      3.times { Fabricate :section_assignment, section: s2 }
      expect( SectionAssignment.filter_by(year: 2003).count).to eq 2
    end
  end
    
end
