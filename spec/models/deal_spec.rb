require 'spec_helper'

describe Deal, :type => :model do

  specify { expect(Deal).to be < Proposable }
  specify { expect(Deal).to be < Conversation }

  # Relations
  it { is_expected.to embed_many :proposals }
  it { is_expected.to embed_many :messages }

  # Attributes
  it { is_expected.to be_timestamped_document }

  # Validations

end
