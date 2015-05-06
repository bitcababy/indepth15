# # encoding: UTF-8
# 
# require 'spec_helper'
# 
# describe Assignment do
#   it { should validate_uniqueness_of :assgt_id }
# 
#   context "Fabricator" do
#     subject { Fabricate(:assignment) }
#     specify { subject.content.should_not be_nil }
#   end
# 
#   context "converting" do
#     describe 'Assignment.import_from_hash' do
#       before :each do
#         @teacher = Fabricate(:teacher, login: 'abramsj')
#         @hash = {content: "This is some content", teacher_id: 'abramsj'}
#       end
#       
#       it "returns an assignment" do
#         expect(Assignment.import_from_hash(@hash)).to be_kind_of Assignment
#       end
#   
#       it "has an author" do
#         asst = Assignment.import_from_hash(@hash)
#         expect(asst.owner).to eq @teacher
#       end
#       it "creates a new assignment if the assgt_id is new" do
#         expect {
#           Assignment.import_from_hash @hash
#         }.to change(Assignment, :count).by(1)
#       end
#       it "updates an assignment if the assgt_id is old" do
#         Assignment.import_from_hash @hash
#         expect {
#           Assignment.import_from_hash @hash
#         }.to change(Assignment, :count).by(0)
#       end
# 
#     end
#   end
# end
# 
# describe Course do
#   describe '::import_from_hash' do
#     it "imports from a hash" do
#       hash = {
#         number: 321,
#         full_name: "Geometry Honors",
#         short_name: "",
#         schedule_name: "GeomH",
#         semesters: 12,
#         credits: 5.0,
#         description: "This is the description",
#         information: "This is the info",
#         policies: "These is the policies",
#         resources: "This is the resources",
#         news: "This is the news",
#         has_assignments:true
#       }
#       course = Course.import_from_hash hash
#       expect(course).to be_kind_of Course
#       expect(course.number).to eq 321
#       expect(course.full_name).to eq "Geometry Honors"
#       expect(course.short_name).to eq ''
#       expect(course.schedule_name).to eq "GeomH"
#       expect(course.duration).to eq Course::FULL_YEAR
#       expect(course.credits).to eq 5.0
#       # expect(course.branches.count).to > 0
#       expect(course.description.content).to eq "This is the description"
#     end
#   end
# end
# 
# describe SectionAssignment do
#   describe 'SectionAssignment.import_from_hash' do
#     before :each do
#       @hash = {
#         :teacher_id=>"davidsonl", 
#         :year=>"2013", 
#         :course_num=>"321",
#         :block=>"D", 
#         :due_date=>"2012-09-06", 
#         :name=>"1", 
#         :use_assgt=>"Y", 
#         :assgt_id =>"614639", 
#         :ada=>"2012-08-19 18:34:40", 
#         :aa=>"2012-08-19 18:37:16"
#       }
#       course = Fabricate :course, number: @hash[:course_num]
#       Fabricate :assignment, assgt_id: @hash[:assgt_id]
#       teacher = Fabricate :teacher, login: @hash[:teacher_id]
#       @section = Fabricate :section, year: @hash[:year].to_i, block: @hash[:block], course: course, teacher: teacher
# 
#     end
# 
#     it "should create a SectionAssignment if it's new" do
#       sa = SectionAssignment.import_from_hash(Hash[@hash])
#       expect(sa).to be_kind_of SectionAssignment
#     end
#     
#     it "should update a SectionAssignment if it's old" do
#       SectionAssignment.import_from_hash(Hash[@hash])
#       @hash[:due_date] = "2012-09-07"
#       expect {
#         SectionAssignment.import_from_hash(Hash[@hash])
#       }.to change(@section.section_assignments.to_a, :count).by(0)
#       @hash[:due_date] = "2012-09-08"
#       sa = SectionAssignment.import_from_hash(Hash[@hash])
#       expect(sa).to be_kind_of SectionAssignment
#       expect(sa.due_date).to eq Date.new(2012, 9, 8)
#     end
#   end
# end
#     
# describe Teacher do
#   context 'importing' do
#     describe '::convert_record' do
#       before :each do
#         @hash = {
#           :default_room=>203, :first_name=>"Joshua", :generic_msg=>"generic message", 
#           :home_page=>"http://www.westonmath.org/teachers/abramsj/math4/quotes.html", 
#           :honorific=>"Mr.", :last_name=>"Abrams", :old_current=>1,
#           :photo_url=>"http://www.westonmath.org/teachers/abramsj/math4/picture.jpg", 
#           :phrase=>"this is a password", :login=>"abramsj", :upcoming_msg=>"Upcoming message"}
#         @teacher = Teacher.import_from_hash(@hash)
#         expect(@teacher).to_not be_nil
#       end
#     
#       it "creates an email address from the teacher_id" do
#         expect(@teacher.email).to eq "abramsj@mail.weston.org"
#       end
#       it "creates a password from the phrase" do
#         expect(@teacher.password).to eq "tiap"
#       end
#       it "sets current from old_current" do
#         expect(@teacher.current).to be_true
#       end
#       
#     end
#   end
# end
# 
# describe Section do
#   describe '::import_from_hash' do
#     it "creates a section from a hash representing an old record" do
#       Fabricate :course, number: 332
#       Fabricate :teacher, login: 'davidsonl'
#       hash = {:dept_id=>1, :course_num=>332, :number=>4, :semesters=>12, :block=>"G", :year=>2011, 
#               :which_occurrences=>"all", :room=>200, :teacher_id=>"davidsonl"}
#       section = Section.import_from_hash(hash)
#       expect(section).to be_kind_of Section
#       pending "Unfinished test"
#     end
#   end
# end
