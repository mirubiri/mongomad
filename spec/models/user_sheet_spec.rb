require 'spec_helper'

describe UserSheet do
  # Modules
  it { should include_module Attachment::Images }
  pending("test autoupdate")

  # Relations
  it { should be_embedded_in :user_sheet_container }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:_id).of_type(Moped::BSON::ObjectId) }
  it { should have_fields :nick, :first_name, :last_name }
  it { should have_field(:location).of_type(Array) }
  pending("test autoupdate fields")

  # Validations
  it { should_not validate_presence_of :user_sheet_container }
  it { should validate_presence_of :_id }
  it { should validate_presence_of :nick }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :location }

  # Checks
  pending("nick coincide con el de user a menos que este outdated")
  pending("first_name coincide con el de user a menos que este outdated")
  pending("last_name coincide con el de user a menos que este outdated")
  pending("location coincide con el de user a menos que este outdated")

  # Methods
  specify '.new' do
    expect(UserSheet.new._id).to eq nil
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
