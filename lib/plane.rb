class Plane
	def initialize
		@flying = true
	end

	def flying?
		@flying
	end

	def land
		@flying=false
		self
	end

	def takeoff
		@flying=true
		self
	end

	def status
		if flying?
			"flying"
		else 
			"landed"
		end
	end
end
