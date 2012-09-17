require 'spec_helper'

describe Bridge do

	describe 'Bridge.create_assignment' do
		it "creates an assignment from a hash and returns true" do
			Bridge.create_assignment('assgt_id' => 123, 'content' => "Foo bar").should be_true
		end
		
		it "returns false if the creation fails" do
			Bridge.create_assignment('assgt_id' => 123, 'content' => "Foo bar")
			Bridge.create_assignment('assgt_id' => 123, 'content' => "Foo bar").should be_false
		end		
	end
	
	describe "Bridge.update_assignment" do
		it "returns false if the assignment doesn't exist" do
			Bridge.update_assignment('assgt_id' => 123, 'content' => "Foo bar").should be_false
		end
		
		it "returns true if the assignment is updated" do
			Bridge.create_assignment('assgt_id' => 123, 'content' => "Foo bar")
			Bridge.update_assignment('assgt_id' => 123, 'content' => "quux").should be_true
		end
	end
			
	describe "Bridge.create_sa"
	
	describe 'find_section_from_hash' do
		it "returns false if there's no section" do
			s = Fabricate :section
			Bridge.find_section_from_hash('course_id' => s.course.number + 1, 'teacher_id' => s.teacher_id, 'block' => s.block, 'academic_year' => s.academic_year).should be_false
		end
		
		it "returns the section if it exists" do
			s = Fabricate :section
			Bridge.find_section_from_hash('course_id' => s.course.number, 'teacher_id' => s.teacher_id, 'block' => s.block, 'academic_year' => s.academic_year).should be_kind_of Section
		end
	end
	
	describe 'delete_sa' do
		before :each do
			t = Fabricate :teacher
			s = Fabricate :section
			s.teacher = t
			puts s.attributes
			a = Fabricate :assignment
			Fabricate :section_assignment, section: s, assignment: a
			@hash = {'course_id' => s.course.number, 'teacher_id' => s.teacher_id, 'block' => s.block, 'academic_year' => s.academic_year, 'assgt_id' => a.assgt_id}
		end
		
		it "returns false if the section doesn't exist" do
			puts @hash
			pending "Unfinished test"
			h = Hash[@hash]
			h['course_id'] += 1
			Bridge.delete_sa(hash).should be_false
		end
	end
			
			
	describe "Bridge.delete_assignment" do
		it "returns false if the assignment doesn't exist" do
			Bridge.delete_assignment('assgt_id' => 123, 'content' => "Foo bar").should be_false
		end
		
		it "returns false if the assignment doesn't exist"
	end
			
	
end

