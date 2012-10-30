#Modules
require 'spec_helper'

describe Proposal do

  #Relations
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_proposal }
    it { should embed_one(:composer) }
    it { should embed_one(:receiver) }
    it { should embed_one(:money) }
  end

  #Attributes
  describe 'Attributes' do
    pending("TODO: Attributes")
  end

  #Validations
  describe 'Validations' do
    #Relations
    it { should validate_presence_of(:composer) }
    it { should validate_presence_of(:receiver) }
    #Attributes
    pending("TODO: Attributes Validations")
  end

  #Behaviour
  describe 'Factory' do
    let (:proposal) { Fabricate(:proposal) }
    specify { proposal.should be_valid }
  end

end
