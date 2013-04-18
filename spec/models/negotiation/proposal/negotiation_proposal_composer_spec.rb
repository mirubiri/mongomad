require 'spec_helper'

describe Negotiation::Proposal::Composer do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:proposal) { negotiation.proposals.last }
  let(:composer) { proposal.composer }

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Negotiation::Proposal) }
    it { should embed_many(:products).of_type(Negotiation::Proposal::Composer::Product) }
  end

  describe 'Attributes' do
    it { should have_field(:nick).of_type(String) }
    it { should have_field(:image_url).of_type(String) }
    it { should accept_nested_attributes_for :products }
    it { should have_denormalized_fields(:nick, :image_url).from('user.profile') }
  end

  describe 'Validations' do
    it { should_not validate_presence_of :proposal }
    it { should validate_presence_of :products }
    it { should validate_presence_of :nick }
    it { should validate_presence_of :image_url }
  end

  describe 'Factories' do
    specify { expect(composer).to be_valid }

    it 'creates one negotiation' do
      expect { composer.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe '#user' do
    subject { composer.user }

    it { should be_instance_of(User) }

    it 'returns user who composed current proposal' do
      expect(subject.id).to eq composer.proposal.user_composer_id
    end
  end
end
