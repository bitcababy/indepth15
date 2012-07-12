# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# def load_records(klass)
# 	path = File.join(File.join(Rails.root, 'new_data'), "#{klass.to_s.tableize}.xml")
# 	begin
# 		file = File.open(path, "r")
# 		hashes = ::XmlSimple.xml_in(path,
# 							'ForceArray' => false,
# 							:conversions => @conversions,
# 		)
# 		klass.delete_all
# 		for hash in hashes do
# 			klass.create! hash
# 		end
# 	ensure
# 		file.close()
# 	end
# end

# [Occurrence, Teacher, Course, Assignment, Section, SectionAssignment, Tag].each {|k| load_records(k)}

MAJOR_TAGS = {
	'Geometry' => [
		'Transformations', 'Similarity', 'Congruence', 'Logic/Proof',
		'Measurement', 'Non-Euclidean', 'Circles', 'Polygons', 'Parallel Lines'],
		'algebra_tags' => [
		'Functions',
		'Quadratics',
		'Exponents/Logs',
		'Systems of Equations',
		'Number Theory',
		'Probability/Combinatorics',
		'Data Distributions',
		'Correlation/Regression',
	],
	'Precalculus' => [
		'Functions',
		'Trigonometry',
		'Probability/Combinatorics',
		'Complex Numbers',
		'Polynomials',
		'Iteration',
		'Rational Functions',
		'Logic/Proof',
		'Number Theory',
	],
	'Calculus' => [
		'Limits',
		'Sequences/Series',
		'Derivatives',
		'Integrals',
		],
	'Statistics' => [
		'Data Distributions',
		'Data Collection',
		'Sampling Distributions',
		'Inference',
		'Correlation/Regression',
		],
	'Discrete Math' => [
		'Inference',
		'Data Collection',
		'Queueing Theory',
		'Manhattan Metric',
		'Game Theory',
		'Graph Theory',
		'Emergence',
		'Risk Analysis',
		],
}

def load_major_tags
	MAJOR_TAGS.each do |b, m|
		branch = Tag::Branch.find_or_create_by label: b
		for mt in m do
			branch.major_tags.find_or_create_by(label: mt)
		end
		branch.save!
	end
end

load_major_tags


		
