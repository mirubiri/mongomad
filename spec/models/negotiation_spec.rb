#Modules
require 'spec_helper'

describe Negotiation do

  #Relations
  describe 'Relations' do
    it { should embed_many :proposals }
    it { should embed_many :messages }
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
    let (:negotiation) { Fabricate(:negotiation) }
    specify { negotiation.should be_valid }
  end

end
