require 'spec_helper'

describe Deal do
  # Variables
  let(:deal) { Fabricate.build(:deal) }

  # Relations
  it { should have_and_belong_to_many :_users }
  it { should embed_many :proposals }
  it { should embed_many :messages }
 
  # Attributes
  it { should be_timestamped_document }

  # Validations
  it { should validate_presence_of :_users }
  it { should validate_presence_of :proposals }
  it { should validate_presence_of :messages }

  # Methods
  describe '#agreement' do
    it 'returns the last proposal' do
      expect(deal.agreement).to eq deal.proposals.last
    end
  end

  # Factories
  specify { expect(Fabricate.build(:deal)).to be_valid }
end
