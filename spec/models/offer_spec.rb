require 'rails_helper'

describe Offer do

  specify { expect(Offer).to be < Proposable }

  # Relations

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :message }
  it { is_expected.to have_field :negotiationa_id }

  # Methods

  describe '#negotiable?' do
    it 'is false when offer is not persisted ' do
      expect(Offer.new.negotiable?).to eq false
    end

    it 'is true when offer is persisted' do
      expect(Offer.create.negotiable?).to eq true
    end
  end
end
