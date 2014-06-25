module Weather
	def weather_status
		(rand(10)==1) ? "stormy" : "sunny"
	end
end