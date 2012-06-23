Fabricator(:assignment, from: :text_document) do
	name					{ sequence(:assignment_name) }
end

Fabricate.sequence(:assignment_name) {|i| i.to_s }

