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

      it 'returns an array' do
        expect(Outdater.outdate(array_to_outdate)).to be_instance_of Array
      end

      it 'returns an array with all members outdated' do
        Outdater.outdate(array_to_outdate)
        array_to_outdate.each do |member|
          expect(member.outdated).to eq true
        end
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
