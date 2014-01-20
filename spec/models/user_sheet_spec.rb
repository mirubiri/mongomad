require 'spec_helper'

describe UserSheet do
  # Modules
  it { should include_module Attachment::Images }

  # Relations
  it { should be_embedded_in :user_sheet_container }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:_id).of_type(Moped::BSON::ObjectId) }
  it { should have_fields :nick, :first_name, :last_name }
  it { should have_field(:location).of_type(Array) }

  # Validations
  it { should_not validate_presence_of :user_sheet_container }
  it { should validate_presence_of :_id }
  it { should validate_presence_of :nick }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :location }

  # Methods
  specify '.new' do
    expect(UserSheet.new.id).to eq nil
  end

  describe '#current_sheet' do
    let(:user) { Fabricate.build(:user) }
    let(:outdated_sheet) { user.sheet }

    before { User.stub(:find).and_return(user) }

    it 'returns the current version of this sheet' do
      expect(outdated_sheet.current_sheet).to eq user.sheet
    end
  end

  # Factories
  specify { expect(Fabricate.build(:user_sheet)).to be_valid }
end
