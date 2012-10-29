#Modules
require 'spec_helper'

describe Agreement do

  #Relations
  describe 'Relations' do
    it { should be_embedded_in (:deal) }
    it { should embed_many(:proposals) }
    it { should embed_many(:messages) }
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
    let (:agreement) { Fabricate(:agreement) }
    specify { agreement.should be_valid }
  end

end
