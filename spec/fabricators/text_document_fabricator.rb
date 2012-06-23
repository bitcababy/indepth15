Fabricator(:text_document, from: :document) do
	contents		''
end

Fabricator(:td_with_contents, class_name: :text_document) do
	contents "Lorem ipsum"
end
