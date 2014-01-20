require 'spec_helper'

describe Deal do
  # Variables
  let(:deal) { Fabricate.build(:deal) }
  let(:first_user_id) { deal.users.first._id }
  let(:second_user_id) { deal.users.last._id }

  # Relations
  it { should have_and_belong_to_many :users }
  it { should embed_many :user_sheets }
  it { should embed_many :proposals }
  it { should embed_many :messages }

  # Attributes
  it { should be_timestamped_document }

  # Validations
  it { should validate_presence_of :users }
  it { should validate_presence_of :user_sheets }
  it { should validate_presence_of :proposals }
  it { should validate_presence_of :messages }

  it 'is invalid when there is no sheet for first user' do
    deal.user_sheets.find(first_user_id)._id = nil
    expect(deal).to have(1).error_on(:user_sheets)
  end

  it 'is invalid when there is no sheet for second user' do
    deal.user_sheets.find(second_user_id)._id = nil
    expect(deal).to have(1).error_on(:user_sheets)
  end

  it 'is invalid if there are more than two user sheets' do
    deal.user_sheets << Fabricate.build(:user_sheet)
    expect(deal).to have(1).error_on(:user_sheets)
  end

  # Methods
  describe '#agreement' do
    it 'returns the last proposal' do
      expect(deal.agreement).to eq deal.proposals.last
    end
  end

  # Factories
  specify { expect(Fabricate.build(:deal)).to be_valid }
end
