module MockDepartmentHelpers
  def mock_department
    docs = []
    5.times do |i|
      docs << mock( 'doc', title: "Title #{i}", content: "Content #{i}", pos: i, to_param: i)
    end
    mock 'dept', homepage_docs: docs
  end
end
