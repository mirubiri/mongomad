require 'spec_helper'

describe Deal do

  # Relations
  it { should embed_many :proposals }
  it { should embed_many :messages }

  # Attributes
  it { should be_timestamped_document }

  # Validations

  specify { expect(Deal).to be < Proposable }
end
