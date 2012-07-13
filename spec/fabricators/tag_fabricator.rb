Fabricator(:tag) do
	documents	[]
end

Fabricator 'Tag::Text', from: :tag do
	content
end

Fabricator 'Tag::Object', from: :tag

Fabricator 'Tag::Author', from: 'Tag::Object'

Fabricator 'Tag::Branch', from: 'Tag::Text'

Fabricator 'Tag::ContentType', from: 'Tag::Text'

Fabricator 'Tag::Major', from: 'Tag::Text'

