require 'spec_helper'

describe Negotiation::Conversation do
  let(:conversation) do
    Fabricate.build(:negotiation).conversation
  end

  describe 'Relations' do
    it { should be_embedded_in :negotiation }
    it { should embed_many(:messages).of_type(Negotiation::Conversation::Message) }
  end

  describe 'Attributes' do
    xit { should have_field(:starter_negotiator_image_name).of_type(Object) }
    xit { should have_field(:follower_negotiator_image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :negotiation }
    it { should validate_presence_of :messages }
    xit { should validate_presence_of :starter_negotiator_image }
    xit { should validate_presence_of :follower_negotiator_image }
  end

  describe 'Factories' do
    specify { expect(conversation.valid?).to eq true }

    it 'creates one negotiation' do
      expect { conversation.save }.to change{ Negotiation.count }.by(1)
    end
  end

  describe 'On save' do
    xit 'has both images' do
      conversation.save
      File.exist?(File.new(conversation.starter_negotiator_image.path)).should eq true
      File.exist?(File.new(conversation.follower_negotiator_image.path)).should eq true
    end
  end

  describe '#self_update' do
    xit 'updates itself'
  end
end
