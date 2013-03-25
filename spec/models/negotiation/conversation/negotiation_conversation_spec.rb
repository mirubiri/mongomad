require 'spec_helper'

describe Negotiation::Conversation do
  let(:offer) { Fabricate(:offer) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:conversation) { negotiation.conversation }

  describe 'Relations' do
    it { should be_embedded_in :negotiation }
    it { should embed_many(:messages).of_type(Negotiation::Conversation::Message) }
  end

  describe 'Attributes' do
    # it { should have_field(:starter_negotiator_name).of_type(String) }
    # it { should have_field(:follower_negotiator_name).of_type(String) }
    # it { should have_field(:starter_negotiator_image_name).of_type(Object) }
    # it { should have_field(:follower_negotiator_image_name).of_type(Object) }
    it { should accept_nested_attributes_for :messages }
    # # Se tienen que llmar igual que en el modelo (:name, :image_name)
    # it { should have_denormalized_fields(:starter_negotiator_name, :starter_negotiator_image_name).from('negotiators.first.profile') }
    # it { should have_denormalized_fields(:follower_negotiator_name, :follower_negotiator_image_name).from('negotiators.last.profile') }
  end

  describe 'Validations' do
   it { should validate_presence_of :negotiation }
   it { should validate_presence_of :messages }
   # it { should validate_presence_of :starter_negotiator_name }
   # it { should validate_presence_of :follower_negotiator_name }
   # it { should validate_presence_of :starter_negotiator_image_name }
   # it { should validate_presence_of :follower_negotiator_image_name }
  end

  describe 'Factories' do
    specify { expect(conversation).to be_valid }

    it 'creates one negotiation' do
      expect { conversation.save }.to change{ Negotiation.count }.by(1)
    end
  end

=begin
  describe 'On save' do
    it 'has two images' do
      conversation.save
      expect(File.exist? conversation.starter_image.path).to eq true
      expect(File.exist? conversation.follower_image.path).to eq true
    end
  end
=end
end
