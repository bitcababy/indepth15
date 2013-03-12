Fabricator(:department) do
  name              { sequence(:dept_name) {|i| "Department #{i}"} }
end

Fabricator :dept, from: :department

Fabricator :department_with_docs, from: :department do
  after_create { |dept|
    3.times { Fabricate :department_document, department: dept }
  }
end

