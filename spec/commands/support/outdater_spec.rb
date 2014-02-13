require 'spec_helper'

describe Outdater do
  # Variables
  let(:array_to_outdate) do
    array_to_outdate = Array.new
    3.times { array_to_outdate << Fabricate.build(:product) }
    array_to_outdate
  end

  # Methods
  describe 'self.outdate(to_outdate[])' do
    context 'when given array is not empty' do
      it 'calls outdate method for every member' do
        array_to_outdate.each do |member|
          expect(member).to receive(:outdate)
        end
        Outdater.outdate(array_to_outdate)
      end

      it 'returns true if all members are outdated' do
        expect(Outdater.outdate(array_to_outdate)).to eq true
      end

      it 'returns false if any member is not outdated' do
        array_to_outdate.last.stub(:outdate).and_return(:true)
        expect(Outdater.outdate(array_to_outdate)).to eq false
      end
    end

    context 'when given array is empty' do
      it 'returns true' do
        expect(Outdater.outdate(Array.new)).to eq true
      end
    end
  end
end
