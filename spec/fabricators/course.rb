Fabricator(:course) do
	number				{ Fabricate.sequence }
	duration			{ ['Full year', 'Semester'].sample }
	credits				{ [ 5.0, 2.5].sample }
	full_name			{ "Course #{Fabricate.sequence}"}
	in_catalog		true
	academic_year	2012
	information
	description
	resources
	policies
	news
end

	
