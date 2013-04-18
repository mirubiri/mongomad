require 'spec_helper'

describe Deal::Agreement::Proposal::Receiver do
  let(:negotiation) { Fabricate(:negotiation) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }
  let(:agreement) { deal.agreement }
  let(:proposal) { agreement.proposals.last }
  let(:receiver) { proposal.receiver }

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Deal::Agreement::Proposal) }
    it { should embed_many(:products).of_type(Deal::Agreement::Proposal::Receiver::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:nick).of_type(String) }
    it { should have_field(:image_url).of_type(String) }
    it { should accept_nested_attributes_for :products }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :proposal }
    it { should validate_presence_of :products }
    it { should validate_presence_of :nick }
    it { should validate_presence_of :image_url }
  end

  describe 'Factories' do
    specify { expect(receiver).to be_valid }

    it 'creates one deal' do
      expect { receiver.save }.to change{ Deal.count }.by(1)
    end
  end
end
