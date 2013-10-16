require 'person'

describe Person do

	let(:person) { Person.new }
	let(:station) { double :station }
	let(:bike) {double :bike}

	it 'has no bike' do
		expect(person).not_to have_bike
	end

	it 'has a bike' do
		person = Person.new (:bike)
		expect(person).to have_bike
	end

	it 'can break a bike' do
		bike = double :bike
		person = Person.new bike
		expect(bike).to receive(:break!)

		person.fall_down
	end

	it 'can rent a bike from a station' do
		expect(station).to receive(:release_bike)
		person.rent_bike_from(station)
	end

	it 'has a bike after renting from a station' do
		station = double :station, release_bike: :bike 
		person.rent_bike_from station		
		expect(person).to have_bike		
	end

	it 'can return a bike to a station' do
		bike = double :bike
		person = Person.new bike
		expect(station).to receive(:dock).with (bike)
		person.return_bike_to(station)
	end

	it 'has no bike after returning to a station' do
		person = Person.new :bike
		station = double :station, { dock: nil }
		person.return_bike_to station		
		expect(person).not_to have_bike		
	end

	it 'cannot rent a bike if it already has one' do
		station = double :station, { release_bike: bike }
		person = Person.new bike
		expect(lambda { person.rent_bike_from(station) }).to raise_error(RuntimeError)
	end
end