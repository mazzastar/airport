require_relative 'weather_conditions'

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
		# @planes.count == self.class::CAPACITY
		@planes.count == CAPACITY
	end

	def accepts(plane)
		raise "Cannot land in storm" if weather_status == "stormy"
		raise "FULL" if full?
		plane.land!
		@planes << plane
		self
	end

	def departs(plane)
		raise "Cannot fly in storm" if weather_status == "stormy"
		plane.takeoff!
		@planes.delete(plane)
		self
	end

	def list_of_planes
		@planes
	end

	def land_all(planes)
		planes.each do |plane|
			begin
				accepts(plane)
			rescue
				retry
			end
		end
		self
	end

	def fly_all
		if full?
			while @planes.empty? ==false
				plane = @planes.pop
				begin
					departs(plane)
				rescue
					retry
				end
			end
		end
		self
	end

end