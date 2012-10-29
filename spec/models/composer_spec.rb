#Modules
require 'spec_helper'

describe Composer do

  #Relations
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_composer }
    it { should embed_many :products }
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
    let (:composer) { Fabricate(:composer) }
    specify { composer.should be_valid }
  end

end
