require 'airport'
require 'plane'
 
describe Airport do
  let(:airport) { Airport.new }
  let(:plane) {double :plane}
  let(:landing_plane) {double :landing_plane, land!: :landing_plane} 
  context 'airport sunny' do 
   
    before do
      airport.stub(:weather_status).and_return("sunny")
    end
   
    context 'airport creation' do
      it 'has no planes when created' do 
        expect(airport).not_to have_planes 
      end

      it 'is not full when created' do 
        expect(airport).not_to be_full
      end

      it 'can be created with planes' do
        airport = Airport.new([plane, plane])
        airport.stub(:weather_status).and_return("sunny")
        expect(airport).to have_planes
      end

    end

    context 'taking off and landing' do
      it 'a plane can land' do
        expect(plane).to receive(:land!)
        airport.accepts(plane)
      end

      it 'has planes after a plane lands' do
        expect(airport.accepts(landing_plane)).to have_planes
      end
      
      it 'a plane can take off' do
        plane = double :plane, land!: nil
        airport.accepts(plane)
        expect(plane).to receive(:takeoff!)
        airport.departs(plane)
      end

      it 'has no planes after plane takes off' do
        plane = double :plane, land!: nil, takeoff!: nil
        airport.accepts(plane)
        expect(airport.departs(plane)).not_to have_planes
      end
    end
  end 

  context 'traffic control' do
    before do
       airport.stub(:weather_status).and_return("sunny")
    end
    it 'a plane cannot land if the airport is full' do
      times = (airport.class::CAPACITY)+1
      expect{times.times{airport.accepts(landing_plane)}}.to raise_error "FULL"
    end
    
    context 'weather conditions' do
      it 'a plane cannot take off when there is a storm brewing' do
        airport = Airport.new([plane])
        airport.stub(:weather_status).and_return("stormy")
        expect{airport.departs(plane)}.to raise_error "Cannot fly in storm"
      end
      
      it 'a plane cannot land in the middle of a storm' do
         airport.stub(:weather_status).and_return("stormy")
         expect{airport.accepts(plane)}.to raise_error "Cannot land in storm"
      end
    end
  end
end
 
describe Plane do
 
  let(:plane) { Plane.new }
  
  it 'has a flying status when created' do
    expect(plane.status).to eq "flying"
  end
  
  it 'can land' do
    plane.land!
    expect(plane.status).to eq "landed"
  end

  it 'can take off' do
    expect(plane.takeoff!).to be_flying
  end
  
  it 'changes its status to flying after taking off' do
    plane.land!
    plane.takeoff!
    expect(plane.status).to eq "flying"
  end
  
end
 
# grand final
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!
describe "The grand finale (last spec)" do
   let(:airport) { Airport.new }

  it 'all planes can land and all planes can take off' do
    planes_to_land = []
    6.times{planes_to_land << Plane.new}
    landing_expected = ["landed"]*6
    airport.land_all(planes_to_land)
    expect(planes_to_land.map{|plane| plane.status}).to eq landing_expected

    flying_expected = ["flying"]*6
    airport.fly_all
    expect(planes_to_land.map{|plane| plane.status}).to eq flying_expected


  end
end