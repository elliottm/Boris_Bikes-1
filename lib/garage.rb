class Garage

	def initialize bikes = [], capacity = 50
		@bikes = bikes
		@capacity = capacity
	end

	def bike_count
		@bikes.count
	end

	def dock bike
		@bikes << bike
	end

	def fix! bike
		bike.fix!
	end

	def working_bikes 
		@bikes.reject { |bike| bike.broken? }
	end


end