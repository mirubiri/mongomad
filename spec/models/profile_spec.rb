require 'rails_helper'

describe Profile do
  let(:profile) { Fabricate.build(:profile) }
  let(:splited_name) { profile.full_name.split}
  let(:first_name) { splited_name.take 1 }
  let(:surnames) { splited_name.drop(1).join(' ') }

  # Modules
  it { is_expected.to include_module Attachment::Images }

  # Relations
  it { is_expected.to be_embedded_in :user }

  # Attributes
  it { is_expected.to be_timestamped_document }
  it { is_expected.to have_fields :full_name, :gender, :language }
  it { is_expected.to have_field(:birth_date).of_type(Date) }
  it { is_expected.to have_field(:location).of_type(Array) }

  # Factories
  specify { expect(Fabricate.build(:profile)).to be_valid }

  describe '#first_name' do
    it 'returns the first word in full_name ' do
      expect(profile.first_name).to eq first_name
    end
  end

  describe '#surnames' do
    it 'returns the surnames on full_name' do
      expect(profile.surnames).to eq surnames
    end
  end
end
