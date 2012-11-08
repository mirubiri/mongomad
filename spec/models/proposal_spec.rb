##Modules
require 'spec_helper'

describe Proposal do
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
    #Relations
    it { should validate_presence_of :polymorphic_proposal }
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
  end

  Behaviour
  describe 'Factory' do
    let (:proposal) { Fabricate.build(:proposal) }
    specify { proposal.should be_valid }
  end
end