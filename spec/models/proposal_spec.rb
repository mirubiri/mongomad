require 'spec_helper'

describe Proposal do
  let(:proposal) { Fabricate.build(:proposal) }

  describe 'Relations' do
    it { should be_embedded_in :polymorphic_proposal }
    it { should embed_one :composer }
    it { should embed_one :receiver }
    it { should embed_one :money }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :polymorphic_proposal }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
  end

  describe 'Factories' do
    specify { proposal.should be_valid }
    specify { proposal.save.should be_true }
  end
end