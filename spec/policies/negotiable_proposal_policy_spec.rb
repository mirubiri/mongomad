require 'rails_helper'

describe NegotiableProposalPolicy do
  let(:proposal) { Fabricate.build(:proposal) }
  let(:policy) { NegotiableProposalPolicy.new(:proposal) }

  describe '#negotiable?' do
    it 'returns true' do
      expect(policy.negotiable?).to eq true
    end
    pending("Implementar si las propuestas son negociables o no,
      dependiendo de la disponibilidad de los goods")
  end

end