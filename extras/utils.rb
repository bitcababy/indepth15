module Utils

# # Instance methods
# 	def before_cutoff?(time)
# 		return Utils.before_cutoff?(time)
# 	end
# 
# 	def after_cutoff?(time)
# 		return Utils.after_cutoff?(time)
# 	end
# 	
# 	def future_due_date
# 		self.future_due_date
# 	end
# 
# 	def next_school_day
# 		self.next_school_day
# 	end

# Class methods
	class << self
		def future_due_date
			time = Time.now
			if after_cutoff?(time)
				Date.tomorrow
			else
				Date.today
			end
		end

		# def before_cutoff?(time)
		# 	@after_cutoff?(time)
		# end
		# 

		def after_cutoff?(time)
			return time.hour > Settings.cutoff.hour || (time.hour == Settings.cutoff.hour && time.min >= Settings.cutoff.minute)
		end

		def next_school_day(day)
		case
			when day.friday?
				day + 3
			when day.saturday?
				day + 2
			else
				day + 1
			end
		end

	end
end

