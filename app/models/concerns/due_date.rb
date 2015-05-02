module DueDate
	extend ActiveSupport::Concern

	module ClassMethods
		def next_school_day
      day = Date.today
			case
			when day.friday?
				day + 3
			when day.saturday?
				day + 2
			else
				day + 1
			end
		end

		def before_cutoff?(time)
			return !after_cutoff?(time)
		end

		def after_cutoff?(time)
			return time.hour > Settings.cutoff[:hour] || (time.hour == Settings.cutoff[:hour] && time.min >= Settings.cutoff[:minute])
		end

		def future_due_date
			time = Time.now.localtime
			if after_cutoff?(time)
				next_school_day
			else
				Date.today
			end
		end
	end

	def before_cutoff?(time)
		return self.class.before_cutoff?(time)
	end

	def after_cutoff?(time)
    return self.class.after_cutoff?(time)
	end

	def future_due_date
    return self.class.future_due_date
	end

  def next_school_day
    return self.class.next_school_day
  end

end
