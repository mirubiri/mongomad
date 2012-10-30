#Modules
require 'spec_helper'

describe Deal do

  #Relations
  describe 'Relations' do
    it { should embed_one(:agreement) }
    it { should embed_many(:messages) }
  end

  #Attributes
  describe 'Attributes' do
    pending("TODO: Attributes")
  end

  #Validations
  describe 'Validations' do
    #Relations
    it { should validate_presence_of(:agreement) }
    it { should validate_presence_of(:messages) }
    #Attributes
    pending("TODO: Attributes Validations")
  end

  #Behaviour
  describe 'Factory' do
    let (:deal) { Fabricate(:deal) }
    specify { deal.should be_valid }
  end

end
