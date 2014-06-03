require 'spec_helper'

describe User, :type => :model do
  # Variables
  let(:user) { Fabricate.build(:user) }

  # Relations
  it { is_expected.to embed_one :profile }

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_field :nick }
  it { is_expected.to have_field(:disabled).of_type(Boolean).with_default_value_of(false) }
  it { is_expected.to delegate(:first_name).to :profile }
  it { is_expected.to delegate(:last_name).to :profile }
  it { is_expected.to delegate(:gender).to :profile }
  it { is_expected.to delegate(:location).to :profile }
  it { is_expected.to delegate(:language).to :profile }
  it { is_expected.to delegate(:birth_date).to :profile }
  it { is_expected.to delegate(:images).to :profile }

  it { is_expected.to delegate(:first_name=).to :profile }
  it { is_expected.to delegate(:last_name=).to :profile }
  it { is_expected.to delegate(:gender=).to :profile }
  it { is_expected.to delegate(:location=).to :profile }
  it { is_expected.to delegate(:language=).to :profile }
  it { is_expected.to delegate(:birth_date=).to :profile }
  it { is_expected.to delegate(:images=).to :profile }

  # Validations

  # Methods
  describe '#sheet' do
    specify { expect(user.sheet.id).to eq user.id }

    it 'returns a UserSheet filled with user data' do
      expect(UserSheet).to receive(:new).with(nick:user.nick, first_name:user.profile.first_name, last_name:user.profile.last_name, images:user.profile.images, location:user.profile.location)
      user.sheet
    end
  end

  describe '#enable' do
    it 'sets disabled field to false' do
      user.enable
      expect(user.disabled).to eq false
    end
  end

  describe '#disable' do
    it 'sets disabled field to true' do
      user.disable
      expect(user.disabled).to eq true
    end
  end

  # Factories
  specify { expect(Fabricate.build(:user)).to be_valid }
end
