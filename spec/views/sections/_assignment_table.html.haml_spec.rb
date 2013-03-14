require 'spec_helper'

describe 'sections/_assignment_table' do
  before do
    stub_template 'sections/_assignment_row' => "Section row"
  end

  shared_examples_for 'any assignment table' do
		it "display a table with the provided assignments" do
      view.stubs(:editable?).returns false
			render partial: 'sections/assignment_table', locals: {sas: []}
			expect(rendered).to have_selector('thead tr') do |row|
				['#', 'Date due', 'Assignment'].each {|hdr| expect(row).to have_selector('th', content: hdr)}
			end
		end
	end

	context "guest mode" do
    it_behaves_like "any assignment table"
  end

	context "user mode" do
    it_behaves_like "any assignment table"

		it "adds a couple of columns" do
      view.stubs(:editable?).returns true
			render partial: 'sections/assignment_table', locals: {sas: []}
			expect(rendered).to have_selector('thead tr') do |row|
				['Assign', 'Actions'].each {|hdr| expect(row).to have_selector('th', content: hdr)}
			end
		end
	end
		
end
