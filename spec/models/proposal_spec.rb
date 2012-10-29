#Modules
require 'spec_helper'

describe Proposal do

  #Relations
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_proposal }
  end

  #Attributes
  describe 'Attributes' do
    pending("TODO: Attributes")
  end

  #Validations
  describe 'Validations' do
    pending("TODO: Validations")
  end

  #Behaviour
  describe 'Factory' do
    let (:proposal) { Fabricate(:proposal) }
    specify { proposal.should be_valid }
  end

end
