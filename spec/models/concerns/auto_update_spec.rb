require 'rails_helper'

class TestSource
  include Mongoid::Document

  field :one, type:String, default:'updated!'
  field :two, type:String, default:'updated!'
end

class TestCopy
  include Mongoid::Document
  include AutoUpdate

  field :one, type:String, default:'outdated!'
  field :two, type:String, default:'outdated!'

  auto_update :one, :two, using: :original

  def original
    TestSource.last
  end
end

describe AutoUpdate do
  let!(:source) do
    TestSource.create!
  end

  subject(:copy) do
    TestCopy.create!
  end

  it { is_expected.to have_field(:outdated).of_type(Mongoid::Boolean).with_default_value_of(false) }

  describe '#auto_update' do
    context 'when is updated' do
      before(:example) { copy.update_attributes(outdated:false) }

      it 'does not change any attribute' do
        expect { copy.auto_update }.to_not change { copy.one }
        expect { copy.auto_update }.to_not change { copy.two }
      end

      it 'does not change any outdated value' do
        expect { copy.auto_update }.to_not change { copy.outdated }
      end

      it 'does not retrieve original object' do
        expect(copy).to_not receive(:original)
        copy.auto_update
      end

      it 'returns true' do
        expect(copy.auto_update).to eq true
      end
    end

    context 'when is outdated' do
      before(:example) { copy.update_attributes(outdated:true) }

      it 'updates all attributes' do
        copy.auto_update
        expect(copy.one).to eq 'updated!'
        expect(copy.two).to eq 'updated!'
      end

      it 'sets outdated status to false' do
        expect { copy.auto_update }.to change { copy.outdated }.from(true).to(false)
      end

      it 'does not save the changes' do
        copy.auto_update
        expect(copy.changes).to_not be_empty
      end
    end
  end

  describe '#outdate' do
    context 'when is updated' do
      before(:example) { copy.update_attributes(outdated:false) }

      it 'outdates the object' do
        expect { copy.outdate }.to change { copy.outdated }.from(false).to(true)
      end

      it 'does not save changes' do
        copy.outdate
        expect(copy.changes).to_not be_empty
      end
    end

    context 'when is outdated' do
      before(:example) { copy.update_attributes(outdated:true) }

      it 'returns true' do
        expect(copy.outdate).to eq true
      end
    end
  end
end
