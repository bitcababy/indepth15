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
	dept.why_doc = TextDocument.create! content: txt

	txt =<<EOT
			<h2>New Department Head</h2>
<p>Please welcome James McLaughlin as the new head of the Math Department for grades 6–12!</p>
EOT
	dept.news_doc = TextDocument.create! content: txt
	
	txt = <<EOT
<h2>WHS Math Department Internal Resources</h2>
	<ul>
	<li><a href=&quot;/files/AcademicSupport_10-11.pdf&quot;>Academic Support</a><br />

	</li>

	</ul>

	<h2>WHS Math Team</h2>
	<ul>
	<li>Visit the <a href=&quot;http://mathteam.westonmath.org/&quot;>Math Team’s homepage</a>!<br />
	<br />
	</li>

	<li><a href=&quot;/files/davidsonl/mathteam/permission-form-2011-12.pdf&quot;>Math Team Permission Form</a><br />
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

	dept.resources_doc = TextDocument.create! content: txt

	txt = <<EOT
	<h2>The Chess Players</h2>
<p>Josh MacKeetch, his sister, his son, and his daughter all play chess.</p>
<p>The best player’s twin and the worst player are of the opposite sex.</p>
<p>The best player and the worst player are of the same age.</p>
<p>Who plays the best game of chess? </p>
EOT
	dept.puzzle_doc = TextDocument.create! content: txt
	
	txt = <<EOT
	<p>This app is your source of information for math courses at Weston High School.
	The tab right below this one lists some of its features, but here’s enough to get you started:
	</p>
	<ul>
<li>This page is called <b>Home</b>.
You can get to it through the <b>Home</b> menu,
which is always the first one at the top of every page.<br />
<br />

</li>
<li>To find information about a particular course,
click on the <b>Courses</b> menu.
You will see a list of all our courses and their sections,
listed by teacher and block number.
Click on any course to read basic information about it,
including the course description and a list of sections,
each with its teacher, block, and room number.
Click on any column header to sort by that column.
Click again to reverse the sort.
Click on a section’s block to see assignments for that section.<br />
<br />
</li>

<li>Course pages also have tabs along the top (below the three standard Westonmath menus).
You can click on any tab to read about the course information,
resources, policies, and news.<br />
<br />
</li>

<li>You can also get to any section’s assignments
by clicking on the section in the <b>Courses</b> menu.
The current assignment is always listed first, followed by any upcoming assignments that have already been posted, followed by all past assignments.
You can choose whether to display 2, 5, 10, or all past assignments.<br />
<br />
</li>

<li>The third menu lists all the <b>Faculty</b> in our Department.
Clicking on the icon to the left of a name takes you to that teacher’s home page,
which includes a list of the courses s/he is currrently teaching.
Clicking on the icon to the right opens up your favorite email program,
with a new message addressed to that teacher.
If you are using a machine that doesn’t have an identified email client,
this option will not work.
<br />
<br />
</li>

<li>The <b>Home</b> page also contains some general information about the Math Department, such as resources, news, and a puzzle that is often (well...occasionally) updated.
Check out the tabs in the accordion!<br />
<br />
</li>

<li>If you spot any bugs, send email to <a href='mailto:davidsonl@weston.org'>Mr. Davidson</a> (DavidsonL@weston.org).</li>
</ul>

EOT
	dept.how_doc = TextDocument.create! content: txt

	dept.save!
end

task :dept => :environment do
	Department.delete_all
	make_department
end

task :default => :dept
