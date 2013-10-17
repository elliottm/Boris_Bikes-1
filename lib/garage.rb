class Garage

	def initialize bikes = [], capacity = 50
		@bikes = bikes
		@capacity = capacity
	end

	def bike_count
		@bikes.count
	end

	def dock bike
		raise "Station is full" if full?
		@bikes << bike
	end

	def fix! bike
		bike.fix!
	end

	def fix_all_bikes
		broken_bikes.each { |bike| fix!(bike) }
	end

	def full? 
		bike_count == @capacity
	end

	def working_bikes 
		@bikes.reject { |bike| bike.broken? }
	end

	def broken_bikes
		@bikes.select { |bike| bike.broken? }
	end
	
	def release_working_bike
		@bikes.delete(working_bikes.first)
	end

	def release_x_working_bikes x
		raise "There are not #{x} working bikes at the garage" if working_bikes.count < x
		Array.new(x).map { release_working_bike }
	end
end