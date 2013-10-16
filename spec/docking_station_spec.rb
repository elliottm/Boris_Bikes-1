require 'docking_station'

describe DockingStation do 

	let(:station) { DockingStation.new [], 20 }
	let(:bike) { double :bike, broken?: false }
	let(:broken_bike) { double :broken_bike, broken?: true }
	let(:broken_bike2) { double :broken_bike, broken?: true }
	let(:broken_bike3) { double :broken_bike, broken?: true }


	it 'can accept a bike' do
		expect(station.bike_count).to eq 0		
		station.dock(bike)
		expect(station.bike_count).to eq 1
	end

	it 'releases a bike' do
		station.dock(bike)
		expect(station.bike_count).to eq 1
		station.release_bike
		expect(station.bike_count).to eq 0
	end	

	it 'tells you if there are no bikes to be released at the station' do
		expect(lambda { station.release_bike } ).to raise_error(RuntimeError)
	end

	it 'knows if the station is full' do
		expect(station).not_to be_full
		20.times { station.dock(bike) }
		expect(station).to be_full
	end

	it 'knows if the station is not full' do
		19.times { station.dock(bike) }
		expect(station).not_to be_full
	end

	it 'does not let you dock a bike if the station is full' do
		20.times { station.dock(bike) }	
		expect(lambda { station.dock(bike) }).to raise_error(RuntimeError)	
	end

	it 'knows which bikes are working' do
		station.dock(bike)
		station.dock(broken_bike)
		expect(station.working_bikes).to eq([bike])
  end

	it 'knows which bikes are broken' do
		station.dock(bike)
		station.dock(broken_bike)
		expect(station.broken_bikes).to eq([broken_bike])
	end

	it 'releases a broken bike' do
		station.dock(bike)
		station.dock(broken_bike)
		expect(station.release_broken_bike).to eq(broken_bike)
	end

	it 'releases all broken bikes' do
		station.dock(bike)
		3.times { station.dock(broken_bike) }
		expect(station.release_all_broken_bikes().length).to eq 3
	end

	it 'releases a select number of broken bikes' do
		station.dock(bike)
		station.dock(broken_bike)
		station.dock(broken_bike2)
		expect(station.release_x_broken_bikes(2).length).to eq 2
	end

	it 'only rents bikes which are not broken' do
		20.times { station.dock(broken_bike) }
		expect(station.release_bike).to be nil
	end

  it 'knows how many free spaces there are' do
    station = DockingStation.new Array.new(7, bike)
    expect(station.slots_available).to eq 13
  end

end