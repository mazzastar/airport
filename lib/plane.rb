class Plane
		@@id =0
	

	def initialize
		@flying = true
		@@id = @@id+1
		@id = @@id

	end

	def flying?
		@flying
	end

	def land!
		@flying=false
		self
	end

	def takeoff!
		@flying=true
		self
	end

	def status
		if flying?
			# puts "flying"
			return "flying"
		else 
			# announcement(@id, "taking off")
			# puts "not flying"
			return "landed"
		end
	end

	def id
		@id
	end

	def announcementOfState
		execString = "say Plane ID #{@id} is #{status}"
		exec execString
	end

end
