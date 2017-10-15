require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'associations' do
    it { is_expected.to have_many(:rides) }
  end

  context 'scopes' do
    describe '#desc' do
      it "is expected to return customers in desc order" do
        customers = Customer.all.desc.pluck(:id)
        expect(customers).to eq(customers.sort {|x,y| -(x <=> y)})
      end
    end

    describe '#hipster' do
      it "is expected to return hipster customers only" do
        expect(Customer.hipster.pluck(:hipster).uniq).to eq([true])
      end

      it "is not expected to return any non hipster customers" do
        expect(Customer.hipster.pluck(:hipster).uniq).not_to eq([false])
      end
    end

    describe '#not_hipster' do
      it "is expected to return not hipster customers only" do
        expect(Customer.not_hipster.pluck(:hipster).uniq).to eq([false])
      end

      it "is not expected to return any hipster customers" do
        expect(Customer.not_hipster.pluck(:hipster).uniq).not_to eq([true])
      end
    end
  end
end
