require 'spec_helper'

describe Request do
  # Variables
  let(:request) { Fabricate.build(:request) }

  # Relations
  it { should belong_to :user }
  it { should embed_one :user_sheet }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :text }
  it { should have_field(:hidden).of_type(Boolean).with_default_value_of(false) }

  # Validations
  it { should validate_presence_of :user }
  it { should_not have_autosave_on :user }
  it { should validate_presence_of :user_sheet }
  it { should validate_length_of(:text).within(1..160) }
  it { should validate_presence_of :hidden }

  # Checks
  it 'is invalid if there is no sheet for user' do
    request.user_id = nil
    expect(request).to have(1).error_on(:user_sheets)
    expect(request.errors_on(:user_sheets)).to include('Request should have one user_sheet for user.')
  end

  # Methods
  describe '#hide' do
    it 'sets hidden field to true' do
      request.hide
      expect(request.hidden).to eq true
    end
  end

  # Factories
  specify { expect(Fabricate.build(:request)).to be_valid }
end
