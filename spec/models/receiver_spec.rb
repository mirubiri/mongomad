#Modules
require 'spec_helper'

describe Receiver do

  #Relations
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_receiver }
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
    let (:receiver) { Fabricate(:receiver) }
    specify { receiver.should be_valid }
  end

end