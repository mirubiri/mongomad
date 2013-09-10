require 'spec_helper'

describe Message do
  let(:message) { Fabricate.build(:message) }

  # Relations
  it { should be_embedded_in :message_container }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :text }

  # Validations
  it { should validate_presence_of :text }
  it { should validate_length_of(:text).within(1..160) }

  # Factories

  specify { expect(message).to be_valid }
end
