require 'spec_helper'

describe 'OneCashPolicy' do
  let(:cash) { [Fabricate.build(:cash)] }
  let(:no_cash) { [] }
  let(:two_cash) { 2.times { Farbicate.build(:cash) }}
  describe '#valid?' do
    context 'cash present' do
      it 'returns true' do
        expect(OneCashPolicy.valid?(cash)).to eq true
      end
    end

    context 'cash not present' do
      it 'returns true' do
        expect(OneCashPolicy.valid?(cash)).to eq true
      end
    end

    context 'more than one cash' do
      it 'returns false' do
        expect(OneCashPolicy.valid?(cash)).to eq false
      end
    end
  end
end
