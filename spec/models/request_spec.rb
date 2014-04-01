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
  it { should have_field(:discarded).of_type(Boolean).with_default_value_of(false) }

  # Validations
  it { should validate_presence_of :user }
  it { should_not have_autosave_on :user }
  it { should validate_presence_of :user_sheet }
  it { should validate_length_of(:text).within(1..160) }
  it { should validate_presence_of :discarded }

  # Checks
  it 'is invalid if there is no sheet for user' do
    request.user_id = nil
    expect(request).to have(1).error_on(:user_sheets)
    expect(request.errors_on(:user_sheets)).to include('Request should have one user_sheet for user.')
  end

  # Methods
  describe '#discard' do
    context 'when request is discarded' do
      before(:each) { request.discarded = true }

      it 'does not change request discarded field' do
        expect{ request.discard }.to_not change{ request.discarded }
      end

      it 'returns false' do
        expect(request.discard).to eq false
      end
    end

    context 'when request is undiscarded' do
      before(:each) { request.discarded = false }

      it 'changes request discarded field to true' do
        expect{ request.discard }.to change{ request.discarded }.from(false).to(true)
      end

      it 'returns true' do
        expect(request.discard).to eq true
      end
    end
  end

  # Factories
  specify { expect(Fabricate.build(:request)).to be_valid }
end
