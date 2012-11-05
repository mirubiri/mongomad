#Modules
require 'spec_helper'

describe Negotiation do

  describe 'Relations' do
    it { should embed_many :proposals }
    it { should embed_many :messages }
  end

  describe 'Attributes' do
    pending("TODO: Attributes")
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    #Relations
    pending("PREGUNTA: Relations Validations")
    it { should validate_presence_of(:proposals) }
    it { should validate_presence_of(:messages) }
    #Attributes
    pending("TODO: Attributes Validations")
  end

  #Behaviour
  describe 'Factory' do
    let (:negotiation) { Fabricate(:negotiation) }
    specify { negotiation.should be_valid }
  end

end
