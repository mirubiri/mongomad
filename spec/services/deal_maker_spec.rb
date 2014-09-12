require 'rails_helper'

describe DealMaker do
  let(:negotiation) { Fabricate.build(:negotiation) }
  
  describe '#make_deal(negotiation)' do
    context 'Negotiation is confirmed' do
    end

    context 'Negotiation is not confirmed' do
    end
  end
end