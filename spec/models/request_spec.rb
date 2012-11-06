#Modules
require 'spec_helper'

describe Request do
  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should have_field(:text).of_type(String) }
  end

  describe 'Validations' do
    #Attributes
    it { should validate_presence_of :text }
  end

  #Behaviour
  describe 'Factory' do
    let (:request) { Fabricate(:request) }
    specify { request.should be_valid }
  end
end