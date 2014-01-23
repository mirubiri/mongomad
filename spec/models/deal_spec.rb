require 'spec_helper'

describe Deal do
  # Variables
  let(:deal) { Fabricate.build(:deal) }

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

  # Checks
  it 'is invalid if there are more than two users' do
    deal.users << Fabricate.build(:user)
    expect(deal).to have(1).error_on(:users)
  end

  it 'is invalid if both users are the same' do
    deal.users[1] = deal.users[0]
    expect(deal).to have(1).error_on(:users)
  end

  it 'is invalid if there are more than two user sheets' do
    deal.user_sheets << Fabricate.build(:user_sheet)
    expect(deal).to have(1).error_on(:user_sheets)
  end

  it 'is invalid if there is no sheet for first dealer' do
    deal.users[0]._id = nil
    expect(deal).to have(1).error_on(:user_sheets)
  end

  it 'is invalid if there is no sheet for second dealer' do
    deal.users[1]._id = nil
    expect(deal).to have(1).error_on(:user_sheets)
  end

  it 'is invalid if there is any proposal not owned by both users simultaneously' do
    deal.proposals << Fabricate.build(:proposal, composer:deal.users.first)
    expect(deal).to have(1).error_on(:proposals)
  end

  it 'is invalid if there is any message not owned by one dealer' do
    deal.messages << Fabricate.build(:message)
    expect(deal).to have(1).error_on(:messages)
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
