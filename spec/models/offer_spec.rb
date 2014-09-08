require 'rails_helper'

describe Offer do

  specify { expect(Offer).to be < Proposable }

  # Relations

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :message }
  it { is_expected.to have_field :negotiation_id }

  # Methods

  describe '#negotiable?' do
    it 'is false when offer is not persisted ' do
      expect(Offer.new).to_not be_negotiable
    end

    it 'is true when offer is persisted and negotiation_id is set' do
      offer=Offer.create(negotiation_id:'0')
      expect(offer).to be_negotiable.and have_attributes negotiation_id:a_truthy_value
    end

    it 'is false if negotiation_id is set' do
      offer=Offer.new(negotiation_id:1)
      expect(offer).to_not be_negotiable
    end
  end
end
