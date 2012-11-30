require 'spec_helper'

describe 'section_assignments/edit' do
  before :each do
    section = mock('section')
    assignment = mock('assignment')
    sa = mock('section_assignment') do
      stubs(:section).returns section
      stubs(:assignment).returns assignment
    end
  end
end
