#Modules
require 'spec_helper'

describe Profile do

  #Relations
  describe 'Relations' do
    it { should be_embedded_in :user }
    it { should embed_one(:photo) }
  end

  #Attributes
  describe 'Attributes' do
    pending("TODO: Attributes")
  end

  #Validations
  describe 'Validations' do
    #Relations
    it { should validate_presence_of :photo }
    #Attributes
    pending("TODO: Attributes Validations")
  end

  #Behaviour
  describe 'Factory' do
    let (:profile) { Fabricate(:profile) }
    specify { profile.should be_valid }
  end

end
