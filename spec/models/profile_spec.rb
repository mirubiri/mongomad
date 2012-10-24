require 'spec_helper'

describe Profile do
  it { should be_embedded_in :user }

  describe 'Factory' do
    let (:profile) { Fabricate(:profile) }
    specify { profile.should be_valid }
  end
end
