require 'spec_helper'

describe Message do
  let(:message) { Fabricate.build(:message) }

  # Relations
  it { should be_embedded_in :message_container }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
  it { should have_field :text }

  # Validations
  it { should_not validate_presence_of :message_container }
  it { should validate_presence_of :user_id }
  it { should validate_length_of(:text).within(1..160) }

  # Methods
  describe '#user' do
    it 'returns the owner user sheet' do
      expect(message.user).to eq message.message_container.user_sheets.find(message.user_id)
    end
  end

  # Factories
  specify { expect(Fabricate.build(:message)).to be_valid }
end
