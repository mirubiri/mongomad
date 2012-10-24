require 'spec_helper'

describe ThingBox do
  describe 'Embedded' do
    it { should be_embedded_in :user }
    it { should embed_many :things }
  end

  describe 'Associated' do
  end

  describe 'Attributes' do
  end

  describe 'Factory' do
    let (:thing_box) { Fabricate(:thing_box) }
    specify { thing_box.should be_valid }
  end
end
