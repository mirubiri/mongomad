require 'spec_helper'

describe Offer do

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
