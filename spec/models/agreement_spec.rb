#Modules
require 'spec_helper'

describe Agreement do
  describe 'Relations' do
    it { should be_embedded_in :deal }
    it { should embed_many :proposals }
    it { should embed_many :messages }
  end

  describe 'Validations' do
    #Relations
    it { should validate_presence_of :deal }
    it { should validate_presence_of :proposals }
    it { should validate_presence_of :messages }
  end


  describe 'Factory' do
    let (:agreement) { Fabricate.build(:agreement) }
    specify { agreement.should be_valid }
  end
end