Fabricator(:document) do
end

Fabricator(:text_document, from: :document) do
	content		''
end

Fabricator(:td_with_content, parent: :text_document) do
	content "Lorem ipsum"
end
