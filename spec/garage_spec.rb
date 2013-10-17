require 'garage'

describe Garage do

	let(:garage) { Garage.new }
	let(:bike) { double :bike, broken?: false}
	let(:bike1) { double :bike, broken?: false}
	let(:bike2) { double :bike, broken?: false}
	let(:broken_bike) { double :broken_bike, broken?: true, fix!: nil }
	let(:broken_bike1) { double :broken_bike, broken?: true, fix!: nil }

	it 'can accept a broken bike' do
		garage = Garage.new 
		expect(garage.bike_count).to eq 0
		garage.dock(broken_bike)
		expect(garage.bike_count).to eq 1
	end

	it 'fixes a bike' do
		expect(broken_bike).to receive(:fix!)
		garage.dock(broken_bike)
		garage.fix!(broken_bike)
	end

	it 'releases a working bike' do
		garage = Garage.new [bike, bike1, broken_bike]
		garage.release_working_bike
		expect(garage.bike_count).to eq 2
	end

	it 'knows if it is not full' do
		garage = Garage.new [bike, bike1, broken_bike]
		expect(garage).not_to be_full
	end

	it 'knows if it is full' do
		50.times { garage.dock(bike) }
		expect(garage).to be_full
	end

	it 'can release a given number of working bikes' do
		garage = Garage.new [bike, bike1, bike2, broken_bike]
		expect(garage.working_bikes.count).to eq 3
		garage.release_x_working_bikes(2)
		expect(garage.working_bikes.count).to eq 1
	end

	it 'can fix all broken bikes' do
		garage = Garage.new [bike, bike1, broken_bike, broken_bike1]
		garage.broken_bikes.each do |broken_bike|
			expect(broken_bike).to receive(:fix!)
		end
		garage.fix_all_bikes
	end

end