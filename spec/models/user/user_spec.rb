require 'spec_helper'

describe User do
  let(:user) do
    Fabricate.build(:user)
  end

  describe 'Relations' do
    it { should embed_one(:profile).of_type(User::Profile) }
    it { should embed_many(:things).of_type(User::Thing) }
    it { should have_many(:requests) }
    it { should have_many(:sent_offers).of_type(Offer) }
    it { should have_many(:received_offers).of_type(Offer) }
    it { should have_and_belong_to_many(:negotiations).of_type(Negotiation) }
    it { should have_and_belong_to_many(:deals).of_type(Deal) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :profile }
  end

  describe 'Factories' do
    specify { expect(user.valid?).to eq true, "Is not valid because #{user.errors}" }
    specify { expect(user.save).to eq true }
  end

  describe '#change_password(old_password,new_password)' do
    xit 'changes old password to the given one'
  end

  describe '#change_email(new_email)' do
    xit 'changes old email to the given one'
  end

  describe '#close_account' do
    xit 'deletes user from the platform'
  end

  describe '#add_thing(thing_form_hash)' do
    xit 'adds a new thing created from the given hash'
  end

  describe '#remove_thing(thing)' do
    xit 'removes the given thing from the user'
  end
end
