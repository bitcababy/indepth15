require "spec_helper"

describe 'assignments routing' do
  it "routes to new with course and teacher params " do
    expect(get: '/courses/1/teachers/2/assignments/new').
      to route_to(
      controller: 'assignments',
      action: 'new',
      course_id: '1',
      teacher_id: '2'
    )
  end
end
    
