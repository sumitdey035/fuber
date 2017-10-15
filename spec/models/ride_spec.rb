require 'rails_helper'

RSpec.describe Ride, type: :model do
  let!(:car)        { create(:car) }
  let!(:customer)   { create(:customer) }
  let!(:ride)       { create(:ride, car: car, customer: customer, start_point: '13.0911,77.3999', end_point: '13.0376,77.5168', start_time: (Time.now.utc - 2.hours), end_time: Time.now.utc) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:car_id) }
    it { is_expected.to validate_presence_of(:customer_id) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:start_point) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:car) }
    it { is_expected.to belong_to(:customer) }
  end

  context 'scopes' do
    describe '#desc' do
      xit "is expected to return rides in desc order" do
        rides = Ride.all.desc.pluck(:id)
        expect(rides).to eq(rides.sort {|x,y| -(x <=> y)})
      end
    end
  end

  context 'methods' do
    describe '#duration' do
      it "is expected to calculate the duration of the ride in minute" do
        expect(ride.duration).to eq(120)
      end
    end

    describe '#ongoing?' do
      let!(:ongoing_ride){ build(:ride, :ongoing) }

      it "is expected to return true if the ride in ongoing" do
        expect(ongoing_ride.ongoing?).to eq(true)
      end

      it "is expected to return false if the ride in already stoped" do
        expect(ride.ongoing?).to eq(false)
      end
    end

    describe '#set_distance' do
      let!(:ride1)       { build(:ride, car: car, customer: customer, start_point: '13.0911,77.3999', end_point: '13.0376,77.5168', start_time: (Time.now.utc - 2.hours), end_time: Time.now.utc) }

      it "is expected to calculate the total distance of the ride in km" do
        ride1.send(:set_distance)
        expect(ride1.distance).to eq(14.0)
      end
    end

    describe '#set_price' do
      let!(:ride1)       { build(:ride, car: car, customer: customer, start_point: '13.0911,77.3999', end_point: '13.0376,77.5168', start_time: (Time.now.utc - 2.hours), end_time: Time.now.utc) }

      it "is expected to calculate and set price of the ride in Dogcoin" do
        ride1.send(:set_distance)
        ride1.send(:set_price)
        expect(ride1.price).to eq(148.0)
      end
    end
  end
end
