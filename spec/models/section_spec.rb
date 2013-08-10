# encoding: UTF-8

require 'spec_helper'

describe Section do
  include Utils
  include SectionsHelpers

  context "Fabrication" do
    it "should create a valid section" do
      s = Fabricate.build :section
      expect(s).to be_valid
    end

    it "should have a course and teacher" do
      s = Fabricate :section
      expect(s.course).to_not be_nil
      expect(s.teacher).to_not be_nil
    end

    it "should be included in the course's sections" do
      t = Fabricate :teacher
      s = Fabricate :section, teacher: t
      expect(t.sections).to include s
    end

    it "can create section_assignments" do
      s = Fabricate :section, sas_count: 3
      expect(s.section_assignments.count).to eq 3
    end

    it "can fabricate a section for an earlier year" do
      s = Fabricate :section, offset: 2
      expect(s.year).to eq Settings.academic_year - 2
    end
  end

  describe '#sync_with_sas' do
    it "update its block, year, course, and teacher to all of its section_assignments" do
      s = Fabricate.build :section
      sa = Fabricate.build :section_assignment, section: s
      expect(s.section_assignments).to include sa
      expect(sa.block).to be_nil
      expect(sa.year).to be_nil
      expect(sa.course).to be_nil
      expect(sa.teacher).to be_nil
      s.save
      expect(sa.block).to eq s.block
      expect(sa.year).to eq s.year
      expect(sa.course).to eq s.course
      expect(sa.teacher).to eq s.teacher
    end
  end

  subject { Fabricate :section }

  context "scopes" do
    before do
      2.times { Fabricate :section, semester: Durations::FULL_YEAR }
      3.times { Fabricate :section, semester: Durations::FIRST_SEMESTER }
      4.times { Fabricate :section, semester: Durations::SECOND_SEMESTER}
    end

    it "should have a 'current' scope" do
      expect(Section.current.count).to eq 9
    end

    # it "should have a 'for_first_semester' scope" do
    #   expect(Section.for_first_semester.count).to eq 5
    # end

    # it "should have a 'for_second_semester' scope" do
    #   expect(Section.for_second_semester.count).to eq 6
    # end

    # it "should have a 'for_semester' scope" do
    #   expect(Section.for_semester(Durations::FIRST_SEMESTER).count).to eq 5
    #   expect(Section.for_semester(Durations::SECOND_SEMESTER).count).to eq 6
    # end

    it "should have a 'for_course' scope" do
      c = Fabricate :course
      8.times { Fabricate :section, course: c }
      expect(Section.for_course(c).count).to eq 8
    end

    it "should have a 'for_teacher' scope" do
      t = Fabricate :teacher
      8.times { Fabricate :section, teacher: t }
      expect(Section.for_teacher(t).count).to eq 8
    end

  end # Scopes

  context "past and future assignment handling" do
    before do
      @section = Fabricate :section
      3.times {|i| @section.section_assignments << Fabricate(:section_assignment_future) }
      2.times {|i| @section.section_assignments << Fabricate(:section_assignment_past) }
      expect(@section.section_assignments.to_a.count).to eq 5
    end

    it "should be able to return all future or past assignments" do
      expect(@section.future_assignments.to_a.count).to eq 3
      expect(@section.past_assignments.to_a.count).to eq 2
      expect(@section.current_assignments.to_a.count).to eq 1
      expect(@section.upcoming_assignments.to_a.count).to eq 2
    end
  end


  describe '#clone' do
    it "makes a new section, updating section_assignments, course, and teacher" do
      course = Fabricate :course
      teacher = Fabricate :teacher
      section = Fabricate :section, course: course, teacher: teacher
      3.times { Fabricate :section_assignment, section: section}
      section.semester = Durations::FIRST_SEMESTER
      clone = section.clone(delete: true)
      expect(course.sections.count).to eq 1
      expect(course.sections.first).to eq clone
      expect(teacher.sections.count).to eq 1
      expect(teacher.sections.first).to eq clone
      expect(SectionAssignment.where(section: clone)).to have(3).records
    end
  end

  # describe "Section.retrieve" do
  #
  #   before :each do
  #     create_some_sections(courses: 2, teachers: 3, years: 2)
  #   end
  #
  #   it "finds all sections for a given year" do
  #     expect(Section.retrieve(year: Settings.academic_year - 1).size).to eq 6
  #   end
  #
  #   it "allows limits" do
  #     expect(Section.retrieve(year: Settings.academic_year - 1, limit: 2).to_a.size).to eq 2
  #   end
  #
  #   it "finds all sections for a given teacher" do
  #     expect(Section.retrieve(teacher: Teacher.first, year: nil).size).to eq 4
  #   end
  #
  #   it "finds all sections for a given course" do
  #     expect(Section.retrieve(course: Course.first, year: nil).size).to eq 6
  #   end
  #
  #   it "finds all sections for a given year and teacher" do
  #     expect(Section.retrieve(teacher: Teacher.first).size).to eq 2
  #   end
  #
  #   it "finds all sections for a given year and course" do
  #     expect(Section.retrieve(course: Course.first).size).to eq 3
  #   end
  #
  # end # Section.retrieve


end
