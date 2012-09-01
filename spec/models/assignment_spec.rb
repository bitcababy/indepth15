# encoding: UTF-8

require 'spec_helper'

describe Assignment do
	
	context "Fabricator" do
		subject { Fabricate(:assignment) }
		specify { subject.content.should_not be_nil }
	end
	
	describe 'Assignment.handle_incoming' do
		before :each do
			Fabricate :teacher, login: 'davidsonl'
			@hash = {assgt_id: "614639", 
				teacher_id: "davidsonl", 
				content: "<ul>\n<li>Read the two documents that we read aloud in class (front and back of the same sheet).\nIf you lose the sheet, here are links to both documents: <a href=\"/teachers/davidsonl/geomh/1-info+expectations.pdf\">Info & Expectations</a> and <a href=\"/teachers/davidsonl/geomh/2-materials.pdf\">Supplies & Materials</a>.<br /><br /></li>\n<li>Start getting your supplies.<br /><br /></li>\n<li>Write your math autobiography, discussing the outstanding highlights and lowlights of your math education.\nYou will probably want to concentrate on the last couple of years, but you should go back as far as you remember.\nIf you have not been in the Weston Public Schools all along,\nbe sure to explain what schools you went to and when.\nIn all cases, describe your math experiences in previous grades.\nInclude specific details about your strengths and weaknesses.\nTell me what works for you in math, and what doesn't work.\nFor example, is practice effective for you? Extra help from the teacher?\nWorking with classmates?<br /><br />\nThis needs to be\nat least one substantial paragraph, but will probably take two or three paragraphs. As a minimum, I suggest 100-150 words.\nYou can find some strong examples from last year <a href=\"/teachers/davidsonl/geomh/autobiog-strong1.pdf\">here</a> and  <a href=\"/teachers/davidsonl/geomh/autobiog-strong2.pdf\">here</a>, and some weak examples <a href=\"/teachers/davidsonl/geomh/autobiog-weak1.pdf\">here</a> and  <a href=\"/teachers/davidsonl/geomh/autobiog-weak2.pdf\">here</a>\n(names and other identifying details have been changed to protect\nthe innocent (and others)).\nSend it to me (DavidsonL@weston.org) in an email message.\nUse <b>math autobiography</b> as your subject.\nIf you have a mysterious email address, like superman42@comcast.net, be sure that your <i>real <i>name appears somewhere!</li>\n</ul>"
			}
		end

		it "creates a new assignment if the assgt_id is new" do
			expect {
				Assignment.handle_incoming @hash
			}.to change(Assignment, :count).by(1)
		end

		it "updates an assignment if the assgt_id is old" do
			Assignment.handle_incoming @hash
				expect {
					Assignment.handle_incoming @hash
				}.to change(Assignment, :count).by(0)
		end
			
	end

	context "converting" do
		describe 'Assignment.import_from_hash' do
			before :each do
				Fabricate(:teacher, login: 'abramsj')
				@assignment = Assignment.import_from_hash({
					name: "3", content: "This is some content", teacher_id: 'abramsj',
					})
				@assignment.should be_kind_of Assignment
			end
			
			it "has an author" do
				@assignment.owner.should_not be_nil
			end
		end
	end

end
