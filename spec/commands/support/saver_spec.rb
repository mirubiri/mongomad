require 'spec_helper'

describe Saver do
  describe 'self.save(to_save[])' do
    context 'when given array is not empty' do
      let(:array_to_save) do
        array_to_save = Array.new
        3.times { array_to_save << Fabricate.build(:product) }
        array_to_save
      end

      it 'calls save method for every member' do
        array_to_save.each do |member|
          expect(member).to receive(:save)
        end
        Saver.save(array_to_save)
      end

      it 'returns an array' do
        expect(Saver.save(array_to_save)).to be_instance_of Array
      end

      it 'returns an array with all members persisted' do
        Saver.save(array_to_save)
        array_to_save.each do |member|
          expect(member).to be_persisted
        end
      end
    end

    context 'when given array is empty' do
      it 'raises an error' do
        expect{ Saver.save(Array.new) }.to raise_error(StandardError, "given array is empty")
      end
    end

    context 'when given array is nil' do
      it 'raises an error' do
        expect{ Saver.save(nil) }.to raise_error(StandardError, "given array is nil")
      end
    end
  end
end
