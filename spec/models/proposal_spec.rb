#Modules
require 'spec_helper'

describe Proposal do
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_proposal }
    it { should embed_one(:composer) }
    it { should embed_one(:receiver) }
    it { should embed_one(:money) }
  end

  describe 'Attributes' do
    it { should have_field(:creation_date).of_type(DateTime) }
  end

  describe 'Validations' do
    #Relations
    it { should validate_presence_of :composer }
    it { should validate_presence_of :receiver }
    #Attributes
    it { should validate_presence_of :creation_date }
  end

  #Behaviour
  describe 'Factory' do
    let (:proposal) { Fabricate(:proposal) }
    specify { proposal.should be_valid }
  end
end