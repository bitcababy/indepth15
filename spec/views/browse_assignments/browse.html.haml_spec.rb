require 'spec_helper'

# describe 'section_assignments/browse' do
#   before :each do
#     courses = (1..3).collect do |i|
#       mock("course #{i}") do
#         stubs(:full_name).returns "Course #{i}"
#       end
#     end
# 
#     teachers = []
#     teachers << mock('teacher') do
#       stubs(:full_name).returns "Horsey Ed"
#     end
#     teachers << mock('teacher') do
#       stubs(:full_name).returns "John Doe"
#     end
#     teachers << mock('teacher') do
#       stubs(:full_name).returns "Red Skelton"
#     end
# 
#     assts = (1..20).collect do |i|
#       mock("Assignment #{i}") do
#         stubs(:name).returns "Assgt #{i}"
#         stubs(:content).returns "Content #{i}"
#       end
#     end
# 
#     sections = (1..5).collect do |i|
#       mock("Section #{i}") do
#         stubs(:year).returns 2013
#       end
#     end
#     sections += (6..10).collect do |i|
#       mock("Section #{i}") do
#         stubs(:year).returns 2012
#       end
#     end
#   
#     for section in sections do
#       section.stubs(:teacher).returns teachers.sample
#       section.stubs(:course).returns courses.sample
#       section.stubs(:block).returns %w(A B C).sample
#     end
# 
#     @sas = (1..10).collect do |i|
#       mock "SectionAssignment #{i}" do
#         stubs(:assignment).returns assts.sample
#         stubs(:section).returns sections.sample
#       end
#     end
# 
#     for sas in @sas do
#       sas.stubs(:year).returns sas.section.year
#       sas.stubs(:course).returns sas.section.course
#       sas.stubs(:teacher).returns sas.section.teacher
#       sas.stubs(:block).returns sas.section.block
#       sas.stubs(:due_date).returns Date.today + (-20..20).to_a.sample
#       sas.stubs(:name).returns sas.assignment.name
#       sas.stubs(:content).returns sas.assignment.content
#     end
#     assign(:sas, @sas)
#     render
#   end
#   
#   it "should have a table" do
#     response.should have_selector('table#sas')
#     pending
#    end
#       
# end
