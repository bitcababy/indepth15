module DepartmentHelper
  def mock_department
    docs = []
    5.times do |i|
      docs << mock('doc') do
        stubs(:content).returns "Some content"
        stubs(:title).returns "A title"
        stubs(:position).returns i
        stubs(:to_param).returns i
      end
    end
    mock('dept') do
      stubs(:homepage_docs).returns docs
    end
  end
end
