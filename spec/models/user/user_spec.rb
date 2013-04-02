require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user) }

  describe 'Relations' do
    it { should have_many(:requests) }
    it { should have_many(:sent_offers).of_type(Offer) }
    it { should have_many(:received_offers).of_type(Offer) }
    it { should have_and_belong_to_many(:negotiations).of_type(Negotiation) }
    it { should have_and_belong_to_many(:deals).of_type(Deal) }
    it { should embed_one(:profile).of_type(User::Profile) }
    it { should embed_many(:things).of_type(User::Thing) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should accept_nested_attributes_for(:profile) }
    it { should accept_nested_attributes_for(:things) }
  end

  describe 'Validations' do
    it { should validate_presence_of :profile }
  end

  describe 'Factories' do
    specify { expect(user).to be_valid }
    specify { expect(user.save).to eq true }
  end

=begin
  describe '#add_thing(thing_params=[])' do
    xit 'adds a new thing created from the given hash'
  end

  describe '#remove_thing(thing_params=[])' do
    xit 'removes the given thing from the user'
  end
=end
end
