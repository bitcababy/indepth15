require "spec_helper"

describe "routing" do
  it "routes a bunch of stuff" do
    expect(get: '/').to route_to("departments#home")
    expect(get: 'courses/1/teachers/doej/assignments/new').to route_to(
    controller: 'assignments',
    action: 'new',
    course_id: "1",
    teacher_id: 'doej'
    )
    expect(get: 'sections/1/assignments_pane').to route_to(
      controller: 'sections',
      action: 'assignments_pane',
      id: "1"
    )
    expect(get: 'departments/1/edit_dept_doc/2').to route_to(
    controller: 'department_documents',
    action: 'edit',
    dept_id: "1",
    id: "2"
    )
    expect(put: 'departments/1/update_dept_doc/2').to route_to(
    controller: 'department_documents',
    action: 'update',
    dept_id: "1",
    id: "2"
    )
    expect(get: 'courses/1/home/2').to route_to(
    controller: 'courses',
    action: 'home',
    id: "1",
    section_id: "2"
    )
    
    expect(get: 'courses/1/pane/sections').to route_to(
    controller: "courses",
    action: 'get_pane',
    kind: "sections",
    id: "1"
    )
    
  end
end
