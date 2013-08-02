require 'spec_helper'

describe Deal::Agreement::Proposal::Composer do
  let(:negotiation) { Fabricate(:negotiation) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }
  let(:agreement) { deal.agreement }
  let(:proposal) { agreement.proposals.last }
  let(:composer) { proposal.composer }

  describe 'Includes' do
    xit 'include ImageManager::ImageHolder'
  end

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Deal::Agreement::Proposal) }
    it { should embed_many(:products).of_type(Deal::Agreement::Proposal::Composer::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should accept_nested_attributes_for :products }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :proposal }
    it { should validate_presence_of :products }
    it { should validate_presence_of :name }
  end

  describe 'Factories' do
    specify { expect(composer).to be_valid }

    it 'creates one deal' do
      expect { composer.save }.to change{ Deal.count }.by(1)
    end
  end
end
