require 'rails_helper'

describe Message do
  # Variables
  let(:user) { Fabricate.build(:user) }
  let(:message) { Fabricate.build(:message, id:user.id) }
  let(:user_sheet) { user.sheet }

  # Relations
  it { is_expected.to be_embedded_in :message_container }

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :text }

  # Validations

  # Methods
  describe '#id' do
    it { is_expected.to have_attributes(id:nil) }
  end
  
  describe '#user_sheet' do
    let(:user_sheet) { user.sheet }

    it 'returns the owner user_sheet' do
      container=Negotiation.new
      container.user_sheets<<user_sheet

      message.message_container=container
      expect(message.user_sheet).to eq user_sheet
    end
  end
end
