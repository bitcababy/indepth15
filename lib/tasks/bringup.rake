task :bringup do
  for task in ['convert:all', 'add_2011:sas', 'fix_durations:courses', 'fix_durations:sections', 'update2014'] do
    Rake::Task[task].execute
  end

end
