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
    it { should have_field(:nickname).of_type(String) }
    it { should have_field(:image_name).of_type(Object) }
    it { should accept_nested_attributes_for :products }
    it { should have_denormalized_fields(:nickname, :image_name).from('user.profile') }
  end

  describe 'Validations' do
    it { should validate_presence_of :proposal }
    it { should validate_presence_of :products }
    it { should validate_presence_of :nickname }
    it { should validate_presence_of :image_name }
  end

  describe 'Factories' do
    specify { expect(receiver).to be_valid }

    it 'creates one deal' do
      expect { receiver.save }.to change{ Deal.count }.by(1)
    end
  end

  describe 'after_save' do
    it 'has an image' do
      receiver.save
      expect(File.exist? receiver.image.path).to eq true
    end
  end

  describe '#user' do
    subject { receiver.user }

    it { should be_instance_of(User) }

    it 'returns user who received current proposal' do
      expect(subject.id).to eq receiver.proposal.user_receiver_id
    end
  end
end
