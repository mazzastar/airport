require 'weather_conditions'

class Airport

	include Weather
	CAPACITY = 6
	def initialize(planes = [])
		@planes = planes
	end

	def has_planes?
		@planes.any?
	end

	def full?
		@planes.count == self.class::CAPACITY
	end

	def accepts(plane)
		raise "Cannot land in storm" if weather_status == "stormy"
		raise "FULL" if full?
		plane.land
		@planes << plane
		self
	end

	def departs(plane)
		raise "Cannot fly in storm" if weather_status == "stormy"
		plane = @planes.delete(plane)
		plane.takeoff
		self
	end



end