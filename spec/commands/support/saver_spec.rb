require 'spec_helper'

describe Saver do
  # Variables
  let(:array_to_save) do
    array_to_save = Array.new
    3.times { array_to_save << Fabricate.build(:product) }
    array_to_save
  end

  # Methods
  describe 'self.save(to_save[])' do
    context 'when given array is not empty' do
      it 'calls save method for every member' do
        array_to_save.each do |member|
          expect(member).to receive(:save)
        end
        Saver.save(array_to_save)
      end

      it 'returns true if all members are saved' do
        expect(Saver.save(array_to_save)).to eq true
      end

      it 'returns false if any member is not saved' do
        array_to_save.last.stub(:save).and_return(:false)
        expect(Saver.save(array_to_save)).to eq false
      end
    end

    context 'when given array is empty' do
      it 'returns true' do
        expect(Saver.save(Array.new)).to eq true
      end
    end
  end
end
