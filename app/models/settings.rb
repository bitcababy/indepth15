class Settings
  if true
  include Mongoid::AppSettings
  
  setting :academic_year
  setting :school
  setting :department
  setting :past_assts_num
  setting :cutoff
  setting :last_block
  setting :max_occurrences
  setting :occurrences
  setting :blocks
  
  # These are temporary
  setting :bridged
  setting :start_year
  
  Settings.academic_year = 2013
  Settings.school = "Weston High School"
  Settings.department = "Math Department"
  Settings.cutoff = {hour: 19, minute: 30}
  Settings.start_year = 2011
  Settings.last_block = "H"
  Settings.max_occurrences = 5
  Settings.blocks = ('A'..'H').to_a
  Settings.bridged = true
  

else
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env
end
end