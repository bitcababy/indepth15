# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for b in ['Geometry', 'Algebra', 'Precalculus', 'Calculus', 'Statistics', 'Discrete Math', 'None') do
	Tag.create! label: b
end

Import::Teacher.load_from_data
Import::Course.load_from_data
Import::Assignment.load_from_data
Import::Section.load_from_data
Import::SectionAssignments.load_from_data
