require 'spec_helper'

describe Outdater do
  describe 'self.outdate(to_outdate[])' do
    context 'when given array is not empty' do
      let(:array_to_outdate) do
        array_to_outdate = Array.new
        3.times { array_to_outdate << Fabricate.build(:product) }
        array_to_outdate
      end

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
      it 'raises an error' do
        expect{ Outdater.outdate(Array.new) }.to raise_error(StandardError, "given array is empty")
      end
    end

    context 'when given array is nil' do
      it 'raises an error' do
        expect{ Outdater.outdate(nil) }.to raise_error(StandardError, "given array is nil")
      end
    end
  end
end
