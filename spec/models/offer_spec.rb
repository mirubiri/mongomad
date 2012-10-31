#Modules
require 'spec_helper'

describe Offer do

  describe 'Relations' do
    it { should embed_one :composer }
    it { should embed_one :receiver }
    it { should embed_one :money }
  end

  describe 'Attributes' do
    pending("TODO: Attributes")
  end

  describe 'Validations' do
    #Relations
    it { should validate_presence_of(:composer) }
    it { should validate_presence_of(:receiver) }
    #Attributes
    pending("TODO: Attributes Validations")
  end

  #Behaviour
  describe 'Factory' do
    let (:offer) { Fabricate(:offer) }
    specify { offer.should be_valid }
  end

end