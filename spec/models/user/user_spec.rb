require 'spec_helper'

describe User do
  let(:user) do
    Fabricate.build(:user)
  end

  describe 'Relations' do
    it { should embed_one(:profile).of_type(User::Profile) }
    it { should embed_many(:things).of_type(User::Thing) }
    it { should have_many(:requests) }
    it { should have_and_belong_to_many(:offers) }
    it { should have_and_belong_to_many(:negotiations) }
    it { should have_and_belong_to_many(:deals) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
  end

  describe 'Validations' do
    it { should validate_presence_of :profile }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  describe 'Factories' do
    specify { expect(user.valid?).to be_true }
  end

  describe '#save' do
    it 'Creates one user' do
      expect { user.save }.to change{ User.count }.by(1)
    end
  end
end
