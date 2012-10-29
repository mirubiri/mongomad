require 'spec_helper'

describe Composer do
  describe 'Relations' do
    it { should be_embedded_in :polymorphic_composer }
    it { should embed_many :products }
  end

  describe 'Factory' do
    let (:composer) { Fabricate(:composer) }
    specify { composer.should be_valid }
  end
end
