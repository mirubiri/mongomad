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
    context 'when request is hidden' do
      before(:each) { request.hidden = true }

      it 'does not change request hidden field' do
        expect{ request.hide }.to_not change{ request.hidden }
      end

      it 'returns false' do
        expect(request.hide).to eq false
      end
    end

    context 'when request is unhidden' do
      before(:each) { request.hidden = false }

      it 'changes request hidden field to true' do
        expect{ request.hide }.to change{ request.hidden }.from(false).to(true)
      end

      it 'returns true' do
        expect(request.hide).to eq true
      end
    end
  end

  # Factories
  specify { expect(Fabricate.build(:request)).to be_valid }
end
