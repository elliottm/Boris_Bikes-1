class Van

	def initialize bikes = [], capacity = 10
		@bikes = bikes
		@capacity = capacity
	end

	def has_bike?
		!(@bikes.empty?)
	end

	def bike_count 
		@bikes.count
	end

	def full?
		bike_count == @capacity
	end

	def slots_available
		@capacity - bike_count
	end

	def number_of_broken_bikes_to_release_from station
		return slots_available if slots_available < station.broken_bikes.count
		station.broken_bikes.count
	end

	def fill_with_broken_bikes_from station	
		@bikes = station.release_x_broken_bikes(number_of_broken_bikes_to_release_from station) 
	end

	def working_bikes 
		@bikes.reject { |bike| bike.broken? }
	end

	def broken_bikes
		@bikes.select { |bike| bike.broken? }
	end

	def dock_working_bike_at station
		station.dock(@bikes.delete(working_bikes.first))
	end

	def dock_broken_bike_at garage
		garage.dock(@bikes.delete(broken_bikes.first))
	end

	def dock_all_working_bikes_at station
		raise "The station does not have enough room for all of the working bikes" if station.slots_available < working_bikes.count
		working_bikes.each { dock_working_bike_at station }
	end

	def dock_all_broken_bikes_at garage
		broken_bikes.each { dock_broken_bike_at garage }
	end

	def number_of_working_bikes_to_release_from garage
		return slots_available if slots_available < garage.working_bikes.count
		garage.working_bikes.count
	end

	def fill_with_working_bikes_from garage	
		@bikes = garage.release_x_working_bikes(number_of_working_bikes_to_release_from garage) 
	end

end