require 'spec_helper'

describe Deal do

  specify { expect(Deal).to be < Proposable }
  specify { expect(Deal).to be < Conversation }

  # Relations
  it { should embed_many :proposals }
  it { should embed_many :messages }

  # Attributes
  it { should be_timestamped_document }

  # Validations

end
