require 'garage'

describe Garage do

	let(:garage) { Garage.new }
	let(:bike) { double :bike, broken?: false }
	let(:broken_bike) { double :broken_bike, broken?: true, fix!: :bike }

	it 'can accept a broken bike' do
		garage = Garage.new 
		expect(garage.bike_count).to eq 0
		garage.dock(broken_bike)
		expect(garage.bike_count).to eq 1
	end

	# it 'fixes a bike' do
	# 	garage.dock(broken_bike)
	# 	garage.fix!(broken_bike)
	# 	expect(garage.working_bikes.count).to eq 1
	# end


end