require 'rails_helper'

describe Profile do
  let(:profile) { Fabricate.build(:profile) }
  let(:one_word_full_name) { "one" }
  let(:many_words_full_name) { "one two three"}
  let(:first_word) { "one" }
  let(:other_words) { "two three"}

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
    context 'one word name' do
      before(:each) { profile.full_name=one_word_full_name}

      it 'returns the first word in full_name ' do
        expect(profile.first_name).to eq first_word
      end
    end

    context 'more than one word name' do
      before(:each) { profile.full_name=many_words_full_name }

      it 'returns the first word in full_name' do
        expect(profile.first_name).to eq first_word
      end
    end
  end

  describe '#surnames' do
    context 'one word name' do
      before(:each) { profile.full_name=one_word_full_name}

      it 'returns an empty string' do
        expect(profile.surnames).to eq String.new
      end
    end

    context 'more than one word name' do
      before(:each) { profile.full_name=many_words_full_name }

      it 'returns the surnames on full_name' do
        expect(profile.surnames).to eq other_words
      end
    end
  end
end
