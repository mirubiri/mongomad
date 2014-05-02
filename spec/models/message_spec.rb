require 'spec_helper'

describe Message do
  # Variables
  let(:user) { Fabricate.build(:user) }
  let(:message) { Fabricate.build(:message, user_id:user.id) }
  let(:user_sheet) { user.sheet }

  # Relations
  it { should be_embedded_in :message_container }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:user_id) }
  it { should have_field :text }

  # Validations
  it { should_not validate_presence_of :message_container }
  it { should validate_presence_of :user_id }
  it { should validate_length_of(:text).within(1..400) }

  # Methods
  describe '#user_sheet' do
    let(:user_sheet) { user.sheet }

    it 'returns the owner user_sheet' do
      container=Negotiation.new
      container.user_sheets<<user_sheet

      message.message_container=container
      expect(message.user_sheet).to eq user_sheet
    end
  end

  # Factories
  specify { expect(Fabricate.build(:message)).to be_valid }
end
