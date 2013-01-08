namespace :dept do
  task convert_docs: :environment do
    dept = Department.first
    unless dept.homepage_docs
      TextDocument.create(title: "How to use the new Westonmath app", content: dept.how_doc.content, owner: dept, key: :how, position: 0)
      TextDocument.create(title: "Why not Teacherweb?", content: dept.why_doc.content, owner: dept, key: :why, position: 1)
      TextDocument.create(title: "News", content: dept.news_doc.content, owner: dept, key: :news)
      TextDocument.create(title: "Resources", content: dept.resources_doc.content, owner: dept, key: :resources)
      TextDocument.create(title: "Puzzle", content: dept.puzzle_doc.content, owner: dept, key: :puzzle)
      dept.how_doc.delete
      dept.why_doc.delete
      dept.news_doc.delete
      dept.resources_doc.delete
      dept.puzzle_doc.delete
      dept.save!
    end
  end
end
  