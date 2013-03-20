# require 'spec_helper'
# 
# describe MajorTopic do
#   describe '#to_s' do
#     it "returns the name of the tag" do
#       mt = Fabricate :major_topic, name: "Foo"
#       expect(mt.to_s).to eq mt.name
#     end
#   end
# 
#   context "Class methods" do
#     describe ':none_topic' do
#       it 'should return the "None" tag' do
#         expect(MajorTopic.none_topic).to be_kind_of NoneTopic
#       end
#     end
#     
#     # describe ':names_for_topics' do
#     #   it "should return an array containing the names of the tags" do
#     #     m1 = Fabricate :major_topic, name: "Foo"
#     #     m2 = Fabricate :major_topic, name: "Bar"
#     #     expect(MajorTopic.names_for_topics(m1, m2)).to eq %w(Foo Bar)
#     #     expect(MajorTopic.names_for_topics([m1, m2])).to eq %w(Foo Bar)
#     #   end
#     # end
#     
#   end
#    
#   describe '#subtopics' do
#     it "adds one or more subtopics" do
#       mt = Fabricate :major_topic, subtopics: []
#       expect( mt.add_subtopics('foo') )
#         .to change { mt.subtopics.count}.by(1)
#       expect { mt.add_subtopics('foo') }
#         .to change { mt.subtopics.count}.by(0)
#     end
#   
#     it "adds the subtopics to @@none_topic" do
#       mt = Fabricate :major_topic, subtopics: []
#       expect { mt.add_subtopics('foo') }
#         .to change { MajorTopic.none_topic.subtopics.count}.by(1)
#     end
#   end
#       
# end
