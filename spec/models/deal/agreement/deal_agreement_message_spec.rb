require 'spec_helper'

describe Deal::Agreement::Message do
  let(:message) do
    Fabricate.build(:deal).agreement.messages.last
  end

  describe 'Relations' do
    it { should be_embedded_in(:agreement).of_type(Deal::Agreement) }
  end

  describe 'Attributes' do
    it { should be_timestamped_document }
    it { should_not have_field(:user_id).of_type(Moped::BSON::ObjectId) }
    it { should have_field(:user_name).of_type(String) }
    it { should have_field(:text).of_type(String) }
    it { should have_field(:image).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :agreement }
    it { should_not validate_presence_of :user_id }
    it { should validate_presence_of :user_name }
    it { should validate_presence_of :text }
    it { should validate_presence_of :image }
  end

  describe 'Factories' do
    specify { expect(message.valid?).to be_true }
    it 'Creates one deal' do
      expect { message.save }.to change{ Deal.count}.by(1)
    end
    it 'Creates one negotiation' do
      expect { message.save }.to change{ Negotiation.count}.by(1)
    end
    it 'Creates one offer' do
      expect { message.save }.to change{ Offer.count}.by(1)
    end
    it 'Creates two users' do
      expect { message.save }.to change{ User.count }.by(2)
    end
  end

  describe '#save' do
    it 'Uploads an image' do
      message.save
      File.exist?(File.new(message.image.path)).should be_true
    end
  end
end
