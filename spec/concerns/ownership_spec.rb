require 'rails_helper'

class TestOwnershipSingle
  include Mongoid::Document
  include Ownership
  ownership :single
end

class TestOwnershipDual
  include Mongoid::Document
  include Ownership
  ownership :dual
end

describe "Ownership" do
  let(:single) { TestOwnershipSingle.new }
  let(:dual) { TestOwnershipDual.new }

  context "ownership :single" do
    subject { TestOwnershipSingle }
    it { is_expected.to embed_one(:user_sheet).of_type(UserSheet) }
    it { is_expected.to have_field(:user_id) }

    describe "#user" do
      it 'returns user_sheet' do
        expect(single).to receive(:user_sheet)
        single.user
      end
    end
  end

  context 'ownership :dual' do
    subject { TestOwnershipDual }
    it { is_expected.to embed_many(:user_sheets).of_type(UserSheet) }
    it { is_expected.to have_field(:user_ids).of_type(Array) }

    describe '#users' do
      it 'returns user_sheets' do
        expect(dual).to receive(:user_sheets)
        dual.users
      end
    end
  end
end
