require 'spec_helper'

describe Deal::Agreement::Proposal::Composer do
  let(:negotiation) { Fabricate(:negotiation) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }
  let(:agreement) { deal.agreement }
  let(:proposal) { agreement.proposals.last }
  let(:composer) { proposal.composer }

  describe 'Relations' do
    it { should be_embedded_in(:proposal).of_type(Deal::Agreement::Proposal) }
    it { should embed_many(:products).of_type(Deal::Agreement::Proposal::Composer::Product) }
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
    specify { expect(composer).to be_valid }

    it 'creates one deal' do
      expect { composer.save }.to change{ Deal.count }.by(1)
    end
  end

  describe 'after_save' do
    it 'has an image' do
      composer.save
      expect(File.exist? composer.image.path).to eq true
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
