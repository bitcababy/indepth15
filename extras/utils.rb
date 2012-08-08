# encoding: UTF-8
module Utils
	extend ActiveSupport::Concern

	module ClassMethods
		def before_cutoff?(time)
			return !after_cutoff?(time)
		end

		def after_cutoff?(time)
			return time.hour > Settings.cutoff.hour || (time.hour == Settings.cutoff.hour && time.min >= Settings.cutoff.minute)
		end

		def future_due_date
			time = Time.now
			if after_cutoff?(time)
				Date.tomorrow
			else
				Date.today
			end
		end

		def next_school_day
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

	def before_cutoff?(time)
		return !after_cutoff?(time)
	end

	def after_cutoff?(time)
		return time.hour > Settings.cutoff.hour || (time.hour == Settings.cutoff.hour && time.min >= Settings.cutoff.minute)
	end

	def future_due_date
		time = Time.now
		if after_cutoff?(time)
			Date.tomorrow
		else
			Date.today
		end
	end

	def next_school_day
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
