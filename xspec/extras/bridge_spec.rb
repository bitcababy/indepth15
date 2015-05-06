# require 'spec_helper'
# 
# describe Bridge do
# 
#   context "assignments" do
#     before :each do
#       @hash = { 'oid' => 123, 'content' => "Foo bar" }
#     end
# 
#     describe 'Bridge.create_assignment' do
#       it "creates an assignment from a hash and returns true" do
#         expect(Bridge.create_assignment(@hash)).to be_true
#       end
#     
#       it "returns false if the creation fails" do
#         Bridge.create_assignment(@hash)
#         expect(Bridge.create_assignment(@hash)).to be_false
#       end    
#     end
#   
#     describe "Bridge.update_assignment" do
#       it "returns false if the assignment doesn't exist" do
#         expect(Bridge.update_assignment(@hash)).to be_false
#       end
#     
#       it "returns true if the assignment is updated" do
#         Bridge.create_assignment(@hash)
#         expect(Bridge.update_assignment('oid' => 123, 'content' => "quux")).to be_true
#       end
#     end
#   end
# 
#   describe 'update_course' do
#     before :each do
#       @course = Fabricate :course
#       @hash = { 
#         'number' => @course.number.to_s,
#         'full_name' => 'Full name',
#         'description' => '',
#         'policies' => '',
#         'resources' => '',
#         'news' => '',
#         }
#     end
#     it "returns false if the assignment doesn't exist" do
#       expect(Bridge.update_course(@hash)).to be_false
#     end
#   end
#       
#   describe "Bridge.create_sa"
#     
#   describe 'delete_sa' do
#     before :each do
#       t = Fabricate :teacher
#       s = Fabricate :section
#       s.teacher = t
#       a = Fabricate :assignment
#       Fabricate :section_assignment, section: s, assignment: a
#       @hash = {'course_id' => s.course.number, 'teacher_id' => s.teacher_id, 'block' => s.block, 'year' => s.year, 'oid' => a.oid}
#     end
#     
#     it "returns false if the section doesn't exist" do
#       pending "Unfinished test"
#       h = Hash[@hash]
#       h['course_id'] += 1
#       expect(Bridge.delete_sa(hash)).to be_false
#     end
#   end
#       
#   describe "Bridge.delete_assignment" do
#     it "returns false if the assignment doesn't exist" do
#       expect(Bridge.delete_assignment('oid' => 123, 'content' => "Foo bar")).to be_false
#     end
#     
#     it "returns false if the assignment doesn't exist"
#   end
#       
#   
# end
# 
