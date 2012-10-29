require 'spec_helper'

describe Profile do
  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Factory' do
    let (:profile) { Fabricate(:profile) }
    specify { profile.should be_valid }
  end
end
