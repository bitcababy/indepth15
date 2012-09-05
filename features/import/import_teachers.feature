Feature: Import teachers
  In order to import the existing teachers
  As a developer
  I want to convert each record into a teacher record


	Scenario: Example
	  Given this yaml record:
		""" id: 1
	  last_name: Abrams
	  first_name: Joshua
	  teacher_id: abramsj
	  title: Mr.
	  default_room: 203
	  phrase: temp
	  photo_URL: /files/teachers/abramsj/math4/picture.jpg
	  personal_hp_URL: /files/teachers/abramsj/math4/quotes.html
	  generic_assgts_msg: Foo
	  upcoming_assgts_msg: Bar
	  extra_stuff: 
	  logged_in: 0
	  current: 1
	  admin_level: none
	  updated_at: 2012-05-11 15:25:06
"""
	  When I import it
	  Then I should create a new teacher:
			 | last_name       | Abrams                                                       |
			 | first_name      | Joshua                                                       |
			 | honorific       | Mr.                                                          |
			 | default_root    | 203                                                          |
			 | photo_url       | /files/teachers/abramsj/math4/picture.jpg |
			 | personal_hp_url | /files/teachers/abramsj/math4/quotes.html  |
			 | general_leadin  | Foo                                                          |
			 | upcoming_leadin | Bar                                                          |
			
			
	
	
	
