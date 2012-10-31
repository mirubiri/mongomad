#Modules
require 'spec_helper'

describe Message do

  describe 'Relations' do
    it { should be_embedded_in :polymorphic_message }
  end

  describe 'Attributes' do
    pending("TODO: Attributes")
  end

  describe 'Validations' do
    #Attributes
    pending("TODO: Attributes Validations")
  end

  #Behaviour
  describe 'Factory' do
    let (:message) { Fabricate(:message) }
    specify { message.should be_valid }
  end

end