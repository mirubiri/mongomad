#Modules
require 'spec_helper'

describe Deal do
  describe 'Relations' do
    it { should embed_one :agreement }
    it { should embed_many :messages }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    #Relations
    it { should validate_presence_of :agreement }
    it { should validate_presence_of :messages }
  end

  #Behaviour
  #describe 'Factory' do
  #  let (:deal) { Fabricate(:deal) }
  #  specify { deal.should be_valid }
  #end
end