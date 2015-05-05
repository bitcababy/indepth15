module Durations
  OLD_FULL_YEAR = 12
  OLD_FULL_YEAR_HALF_TIME = 3
  OLD_FIRST_SEMESTER = 1
  OLD_SECOND_SEMESTER = 2
  OLD_ONE_SEMESTER = 6

  FULL_YEAR = :full_year
  FULL_YEAR_HALF_TIME = :full_year_half_time
  FIRST_SEMESTER = :first_semester
  SECOND_SEMESTER = :second_semester
  ONE_SEMESTER = :one_semester


  DURATIONS = [ FULL_YEAR, FIRST_SEMESTER, SECOND_SEMESTER, FULL_YEAR_HALF_TIME, ONE_SEMESTER ]
  SEMESTERS = [FULL_YEAR, FIRST_SEMESTER, SECOND_SEMESTER]

  def self.old_to_new(dur)
    return case(dur)
    when OLD_FULL_YEAR
      FULL_YEAR
    when OLD_ONE_SEMESTER
      ONE_SEMESTER
    when OLD_FULL_YEAR_HALF_TIME
      FULL_YEAR_HALF_TIME
    when OLD_SECOND_SEMESTER
      SECOND_SEMESTER
    when OLD_FIRST_SEMESTER
      FIRST_SEMESTER
    else
      dur
    end
  end

  def self.semester_to_i(sem)
    return case sem
    when FIRST_SEMESTER
      1
    when SECOND_SEMESTER
      2
    when FULL_YEAR
      12
    end
  end


  def self.to_s(dur)
    return case dur
    when FULL_YEAR
      "Full Year"
    when FIRST_SEMESTER
      "First semester"
    when SECOND_SEMESTER
      "Second semester"
    when FULL_YEAR_HALF_TIME
      "Full year, half time"
    when ONE_SEMESTER
      "One semester"
    end
  end

  def self.duration_to_option(dur)
    return {dur .to_s=> Durations.to_s(dur)}
  end

  def self.durations_to_options
    return DURATIONS.collect {|dur| self.duration_to_option dur }
  end

  def self.semester_to_option(sem)
    return {sem .to_s=> SEMESTERS.to_s(sem)}
  end


  def self.semesters_to_options
    return SEMESTERS.collect {|sem| self.semester_to_option sem }
  end

end
