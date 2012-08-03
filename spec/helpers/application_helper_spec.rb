# encoding: UTF-8

require 'spec_helper'

describe ApplicationHelper do
	include CourseExamplesHelper

	describe '#academic_year_string' do
		it "returns a string for the full academic year" do
			academic_year_string(2012).should == "2011—2012"
		end
	end
	
	describe '#assignment_date_string' do
		it "returns the dotw, followed by the month and day" do
			assignment_date_string(Date.new(2012, 7, 12)).should == "Thu, Jul 12"
		end
	end

	describe "#render_home_menu" do
		before :each do
			@res = render_home_menu
		end

		it "renders a line item" do
			@res.should have_selector('li', class: 'home') do |li|
				li.should have_selector('a', href: home_path, content: 'Home')
			end
		end
		
		it "renders the 'Sign in' item" do
			@res.should have_selector('ul', id: 'home-menu') do |ul|
				ul.should have_selector('li', id: 'sign_in_out') do |li|
					li.should have_selector('a', href: sign_in_path, content: "Sign in")
				end
			end
		end
		
		it "renders the 'About' item" do
			@res.should have_selector('ul', id: 'home-menu') do |ul|
				ul.should have_selector('li', id: 'about') do |li|
					li.should have_selector('a', href: about_path, content: 'About')
				end
			end
		end
			
	end
				
	context "courses menu" do
		
		describe '#render_sections_of_course' do
			it "renders one course as an unordered list" do
				pending "Unfinished test"
				course = course_with_sections
				
				res = render_sections_of_course(course)
				course.sections.each do |section|
					res.should have_selector('li.section a', href: assignments_page_path(section.course.number, section.block), content: section_label_for_menu(section))
				end
			end
		end

		describe "#render_courses_menu" do
			before :each do
				Fabricate :course
				pending "Unfinished test"
				10.times { Fabricate :course }
				pending "Unfinished test"
				Course.each {|course| (1..5).to_a.any.times {Fabricate(:section, course: course)}}
				@res = render_courses_menu
			end
		
			it "renders a line item" do
				@res.should have_selector('li', class: 'courses', content: 'Courses')
			end
		
			it "renders each course" do
				@res.should have_selector('ul', class: 'course-list') do |ul|
					Course.each do |course|
						ul.should have_selector('li') do |div|
							div.should have_selector('a', href: home_course_path(course), content: course.full_name)
						end
					end
				end
			end	
		end
	end

	describe "#render_faculty_menu" do
		before :each do
			5.times {Fabricate(:teacher)}
			@res = render_faculty_menu
		end
	
		it "renders a 'Faculty' item" do
			pending "Unfinished test"
			@res.should have_selector('li', content: 'Faculty') 
		end
	
		it "renders the faculty menu" do
			pending "Unfinished test"
			@res.should have_selector('ul', id: 'faculty-list') do |ul|
				Teacher.each do |teacher|
					ul.should have_selector('li.teacher', content: teacher.full_name)
					ul.should have_selector('li.home-page a', href: home_teacher_path(teacher), content: 'Home page')
				end
			end
		end
	end

	describe "#render_manage_menu" do
		it "renders the faculty menu"
	end

	describe "#render_menubar" do
		it "renders the menubar"
	end
end

	