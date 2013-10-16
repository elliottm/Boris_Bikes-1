class Person

	def initialize (bike=nil)
		@bike = bike
	end

	def has_bike?
		!@bike.nil?
	end

	def fall_down
		@bike.break!
	end

	def rent_bike_from station
		raise "This person already has a bike" if self.has_bike?
		@bike = station.release_bike
	end

	def return_bike_to station
		station.dock @bike
		@bike = nil
	end

end