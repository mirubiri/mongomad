require 'spec_helper'

describe Request do
  let(:request) { Fabricate.build(:request) }

  # Relations
  it { should belong_to :user }
  it { should embed_one(:user_sheet).of_type(UserSheet) }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :text }

  # Validations
  it { should validate_presence_of :user }
  it { should_not have_autosave_on(:user) }
  it { should validate_presence_of :user_sheet }
  it { should validate_length_of(:text).within(1..160) }

  # Checks
  it 'is invalid if there is no sheet for user' do
    request.user_id = nil
    expect(request).to have(1).error_on(:user_sheets)
    expect(request.errors_on(:user_sheets)).to include('Request should have one user_sheet for user.')
  end

  # Factories
  specify { expect(Fabricate.build(:request)).to be_valid }
end
