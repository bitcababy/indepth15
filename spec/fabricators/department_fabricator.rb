Fabricator(:department) do
  name              { sequence(:dept_name) {|i| "Department #{i}"} }
  homepage_docs     []
end

Fabricator :dept, from: :department

Fabricator :department_with_docs, from: :department do
  after_build { |dept|
    3.times { dept.homepage_docs << Fabricate(:department_document) }
  }
end

