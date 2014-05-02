require 'spec_helper'

describe Offer do

  let(:composer) { Fabricate.build(:user) }
  let(:receiver) { Fabricate.build(:user) }
  let(:proposal) do
    Proposal.new
    proposal.composer_id=composer.id
    proposal.receiver_id=receiver.id
  end
  let(:composer_sheet) { composer.sheet }
  let(:receiver_sheet) { receiver.sheet }
  let(:offer) { Offer.new }

  specify { expect(Offer).to be < Proposable }
  
  # Relations
  it { should belong_to :negotiation }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :message }

  # Methods

  describe '#negotiate' do
  end
  # Factories
end
