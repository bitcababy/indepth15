Then /^I should (?:visit|go to|see) the "([^"]+)" page$/ do |page_name|
	case page_name
	when "About"
		pending "Unfinished test"
	else
		pending 
	end
end

