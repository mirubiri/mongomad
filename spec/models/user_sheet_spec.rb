require 'rails_helper'

describe UserSheet do
  # Variables
  let(:user) { Fabricate.build(:user) }
  let(:user_sheet) { user.sheet }

  # Modules
  it { is_expected.to include_module Attachment::Images }
  it { is_expected.to include_module AutoUpdate }

  # Relations
  it { is_expected.to be_embedded_in :user_sheet_container }

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field(:_id).of_type(BSON::ObjectId) }
  it { is_expected.to have_fields :nick, :full_name }
  it { is_expected.to have_field(:location).of_type(Array) }
  it { is_expected.to auto_update(:nick, :full_name, :location, :images).using :current_sheet }

  # Validations
  it { is_expected.not_to validate_presence_of :user_sheet_container }

  # Methods
  specify '.new' do
    expect(UserSheet.new.id).to eq nil
  end

  describe '#current_sheet' do
    before(:example) do
      user.save
      user_sheet.nick = 'outdated'
    end

    it 'returns the current version of this sheet' do
      expect(user_sheet.current_sheet).to eq user.sheet
    end
  end

  describe '#first_name' do
    it 'returns the first word in full_name ' do
      expect(user_sheet.first_name).to eq user.first_name
    end
  end

  describe '#surnames' do
    it 'returns the surnames on full_name' do
      expect(user_sheet.surnames).to eq user.surnames
    end
  end

  # Factories
end
