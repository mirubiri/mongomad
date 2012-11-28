require 'spec_helper'

describe Negotiation do
  #let(:negotiation) { Fabricate.build(:negotiation) }
  #after(:each) { negotiation && negotiation.destroy }

  describe 'Relations' do
    it { should embed_many(:proposals).of_type(Negotiation::Proposal) }
    it { should embed_many(:messages).of_type(Negotiation::Message) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :messages }
  end

=begin
  describe 'Factories' do
    specify { negotiation.should be_valid }
    specify { negotiation.save.should be_true }
  end
=end
end