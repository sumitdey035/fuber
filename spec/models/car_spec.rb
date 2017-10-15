require 'rails_helper'

RSpec.describe Car, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_presence_of(:model) }
    it { is_expected.to validate_presence_of(:uniq_id) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lng) }
    it { is_expected.to validate_uniqueness_of(:uniq_id) }
  end

  context 'associations' do
    it { is_expected.to have_many(:rides) }
  end

  context 'scopes' do
    describe '#desc' do
      it "is expected to return cars in desc order" do
        cars = Car.all.desc.pluck(:id)
        expect(cars).to eq(cars.sort {|x,y| -(x <=> y)})
      end
    end

    describe '#available' do
      it "is expected to return available cars only" do
        expect(Car.available.pluck(:available).uniq).to eq([true])
      end

      it "is not expected to return any not available cars" do
        expect(Car.available.pluck(:available).uniq).not_to include(false)
      end
    end

    describe '#not_available' do
      let!(:not_available)     { create(:car, :not_available) }

      it "is expected to return not available cars only" do
        expect(Car.not_available.pluck(:available).uniq).to eq([false])
      end

      it "is not expected to return any available cars" do
        expect(Car.not_available.pluck(:available).uniq).not_to include(true)
      end
    end
  end

  context 'methods' do
    describe "#nearest" do
      it "is expected to return nearest available car" do
        customer_point  = '12.9825, 77.4961'
        closest_dstance = Car.available.collect {|car| car.cauculate_distance("#{car.lat},#{car.lng}", customer_point) }.min
        closest_car     = Car.nearest(customer_point)
        expect(closest_car.cauculate_distance("#{closest_car.lat},#{closest_car.lng}", customer_point)).to eq(closest_dstance)
      end

      it "is not expected to return any not available car" do
        expect(Car.nearest('12.9825,77.4961').available).to eq(true)
      end

      it "is expected to return blank if not cars are available" do
        Car.limit(10).update_all(available: false)
        expect(Car.not_available.nearest('12.9825, 77.4961')).to eq(nil)
      end
    end

    describe "#start_ride" do
      it "is expected to make it not available" do
        car = Car.available.last
        car.start_ride
        expect(car.available).to eq(false)
      end
    end

    describe "#stop_ride" do
      it "is expected to make it available and update its location" do
        car = Car.available.last
        car.start_ride
        car.stop_ride('1.3,104.0')
        expect(car.available).to eq(true)
        expect("#{car.lat},#{car.lng}").to eq('1.3,104.0')
      end
    end
  end
end
