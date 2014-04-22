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
		plane2 = @planes.delete(plane)
		# plane2.takeoff!
		# puts plane2.status
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
		# self
	end

	def fly_all
		if full?
			# puts @planes.inspect
			# puts full?
			# puts @planes.length
			while @planes.empty? ==false
				plane = @planes.pop
				begin
					departs(plane)
				rescue
					retry
				end
			end

			# @planes.each do |plane|
			# 	 begin
			# 		departs(plane)
			# 		if plane.status == "landed"
			# 			# departs(plane)
			# 		end
			# 		# puts plane.status
			# 	 rescue
			# 		# puts plane.status

			# 		 retry
			# 	 end
			# end
		end
		puts @planes.inspect

		# self
	end

end