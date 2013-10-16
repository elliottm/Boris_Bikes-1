class Van

	def initialize bikes = [], capacity = 10
		@bikes = bikes
		@capacity = capacity
	end

	def has_bike?
		!(@bikes.empty?)
	end

	def collect_broken_bike_from station
		@bikes << station.release_broken_bike
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

	def number_of_bikes_to_release_from station
		return slots_available if slots_available < station.broken_bikes.count
		station.broken_bikes.count
	end

	def fill_with_broken_bikes_from station	
		@bikes = station.release_x_broken_bikes(number_of_bikes_to_release_from station) 
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

	def dock_all_working_bikes_at station
		raise "The station does not have enough room for all of the working bikes" if station.slots_available < working_bikes.count
		working_bikes.each { dock_working_bike_at station }
	end

	def deliver_broken_bikes_to garage
		garage.dock
	end

end