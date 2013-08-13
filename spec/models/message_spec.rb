require 'spec_helper'

describe Message do
  # let(:offer) { Fabricate(:offer) }
  # let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  # let(:conversation) { negotiation.conversation }
  # let(:message) { conversation.messages.last }

  # Relations
  it { should be_embedded_in :message_container }
  it { should embed_one(:sheet).of_type(UserSheet) }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :text }

  # Validations
  it { should validate_presence_of :sheet }
  it { should validate_presence_of :text }
  it { should validate_length_of(:text).within(1..160) }

  # Factories

  #   specify { expect(message).to be_valid }

  #   it 'creates one negotiation' do
  #     expect { message.save }.to change{ Negotiation.count }.by(1)
  #   end

  # describe '#user' do
  #   subject { message.user }

  #   it { should be_instance_of(User) }

  #   it 'returns user who posted current message' do
  #     expect(subject.id).to eq message.user_id
  #   end
  # end
end
