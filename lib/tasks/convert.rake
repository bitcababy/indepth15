# encoding: UTF-8

def make_department
	dept = Department.create! name: Settings.dept_name
	txt =<<EOT
	<p>Students keep asking, “Why doesn’t the Math Department just use teacherweb?” One student even asked whether we’re too cool for teacherweb.</p>
	<p>The WHS Math Department admits to being cool, but that’s not what westonmath is all about. The westonmath.org website is far more than a place to find out tonight’s homework assignment. Here are some of its features:</p>
	<ul>
		<li> The “Current Assignment” automatically rolls over every afternoon. The teacher doesn’t have to remember to do so manually. Future assignments aren’t confused with the current one.</li>
	<li>You have an easily accessible database of all past assignments. Even in June it stretches all the way back to September.</li>
		<li>	Teachers have access to past assignments in every course going back to 2002. This is extremely helpful for experienced teachers and newcomers alike.</li>
	<li>Westonmath is course-oriented rather than teacher-oriented. Students, parents, and teachers can easily find out 
	important information about a course, such as its syllabus and its grading policies. Even if there are four or five different 
	teachers for a course, all the course-wide data are collected in a single place.</li>
	<li>Department-wide information is readily available on the front page.</li>
	</ul>
EOT
	dept.why_doc = TextDocument.create content: txt

	txt =<<EOT
<p>The courses in mathematics emphasize the pattern, structure, and unifying ideas of the discipline. Since we have witnessed tremendous growth in uses of mathematics during the past thirty years, it is virtually impossible to predict all our future mathematical needs. We attempt to provide opportunities for students to achieve the mathematical, statistical, and computer literacy that will be required by tomorrow's society. Problem-solving skills are one of the major emphases of our program.</p>
						<p></p>
						<h2>Curriculum Levels</h2>
						<p>The department's program...</p>
						<p></p>
						<h2>Course Placement</h2>
						<p>The following guidelines...</p>
EOT
	dept.info_doc = TextDocument.create content: txt
			txt =<<EOT
<p>A power-point presentation prepared for the January 23, 2008, curriculum night 
presentation summarizing the Weston High School math course options may be accessed  
<a href=&quot;http://www.westonmath.org/teachers/mccowand/PTO2008.ppt&quot;
>here</a>.  The last slide gives contact information for the department chairman 
if there are questions.</column>
EOT

	dept.news_doc = TextDocument.create content: txt
	txt = <<EOT
<h2>WHS Math Department Internal Resources</h2>
	<ul>
	<li><a href=&quot;http://www.westonmath.org/AcademicSupport_10-11.pdf&quot;>Academic Support</a><br />

	</li>

	</ul>

	<h2>WHS Math Team</h2>
	<ul>
	<li>Visit the <a href=&quot;http://mathteam.westonmath.org/&quot;>Math Team’s homepage</a>!<br />
	<br />
	</li>

	<li><a href=&quot;http://www.westonmath.org/teachers/davidsonl/mathteam/permission-form-2011-12.pdf&quot;>Math Team Permission Form</a><br />
	<br />
	</li>

	<li><a href=&quot;http://mathteam.westonmath.org/calendar-2008-09.pdf&quot;>Math Team Calendar</a><br />

	</li>

	</ul>
	<hr />

	<h2>External Resources</h2>
	<ul><li>Alexander Bogomolny always has a wealth of fascinating challenges at his <a href=&quot;http://www.cut-the-knot.org&quot;>Cut the Knot</a> site.<br />
				<br />
				</li>


				<li>The <a href=&quot;http://coolmath.com/&quot;>Cool Math</a> site contains useful links to a lot of other interesting math sites.<br />
				<br />
				</li>

				<li>Get your math puzzles <a href=&quot;http://www.mathpuzzle.com/&quot;>here</a>!<br />
				<br />
				</li>
				<li>The <a href=&quot;http://www-groups.dcs.st-and.ac.uk:80/%7ehistory/index.html&quot;>history of math</a> provides a useful context that can inform and enliven what you’re learning.<br>
					<br>
				</li>
			</ul>
EOT
	dept.resources_doc = TextDocument.create content: txt

	txt = <<EOT
	<h2>The Chess Players</h2>
<p>Josh MacKeetch, his sister, his son, and his daughter all play chess.</p>
<p>The best player’s twin and the worst player are of the opposite sex.</p>
<p>The best player and the worst player are of the same age.</p>
<p>Who plays the best game of chess? </p>
EOT
	dept.puzzle_doc = TextDocument.create content: txt
	dept.save!
end

namespace :data do
	task :convert => :environment do
	  Mongoid.unit_of_work(disable: :all) do
			[Occurrence, Teacher, Course, Section, Assignment, SectionAssignment].each do |klass|
				arr = Convert.import_old_file "#{klass.to_s.tableize}.xml"
				Convert.from_hashes klass, arr
			end
		end
	end
	task :dept => :environment do
		Department.delete_all
		make_department
	end
		
end

task :default => ':data:convert'
