INTEGER = Transform /^(\d+)$/ do |d|
	d.to_i
end

Transform /^I'm$/ do |ignore|
	"I am"
end


Transform /^I've$/ do |ignore|
	"I have"
end
