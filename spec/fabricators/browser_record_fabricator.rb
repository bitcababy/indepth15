Fabricator(:browser_record) do
  academic_year { Settings.academic_year }
  course_name   { "Course #{sequence(:cn, 1)}"}
  first_name    "John"
  last_name     { "Doe#{sequence(:ln, 1)}"}
  block         { ('A'..'H').to_a.sample }
  due_date      { Date.today + (-5..5).to_a.sample}
end
