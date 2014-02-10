require 'spec_helper'

describe UserUpdater do
  # Variables
  let(:original_user) { Fabricate.build(:user_with_items) }
  let(:request) { Fabricate.build(:request, user:original_user) }
  let(:offer) { Fabricate.build(:offer, user_composer:original_user) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }
  let(:updated_user) do
    original_user.nick = 'new_nick'
    original_user.profile.first_name = 'new_first_name'
    original_user.profile.images << Fabricate.build(:image_face, main:false)
    original_user.profile.set_main_image(original_user.profile.images.last._id)
    original_user
  end

  # Methods
  describe '#initialize(updated_user)' do
    context 'when updated_user is not nil' do
      let!(:user_updater) { UserUpdater.new(updated_user) }

      it 'creates an instance of UserUpdater' do
        expect(user_updater).to be_instance_of UserUpdater
      end

      it 'uses given updated_user' do
        expect(user_updater.user).to eq updated_user
      end
    end

    context 'when updated_user is nil' do
      let!(:user_updater) { UserUpdater.new(nil) }

      it 'returns nil' do
        expect(user_updater).to eq nil
      end
    end
  end

  describe '#execute()' do
    let!(:user_updater) { UserUpdater.new(updated_user) }

    context 'when original_user exists' do
      before(:each) { original_user.save }

      it 'returns true' do
        expect(user_updater.execute()).to eq true
      end

      it 'updates original_user data' do
        user_updater.execute()
        expect(User.find(original_user._id)).to eq updated_user
      end

      it 'calls save method for user' do
        expect(user_updater.user).to receive(:save)
        user_updater.execute()
      end

      it 'saves user' do
        user_updater.execute()
        expect(user_updater.user).to be_persisted
      end

      it 'creates an ObjectFinder instance with user' do
        expect(ObjectFinder).to receive(:new).with(user_updater.user)
        user_updater.execute()
      end

      it 'calls ObjectFinder.execute method with user' do
        expect_any_instance_of(ObjectFinder).to receive(:execute).with(user_updater.user)
        user_updater.execute()
      end

      context 'when there are documents related to user' do
        before(:each) do
          request.save
          offer.save
          negotiation.save
          deal.save
        end

        let(:related_documents) do
          related_documents = Array.new
          related_documents << request
          related_documents << offer
          related_documents << negotiation
          related_documents << deal
          related_documents
        end

        it 'outdates usersheet for every related document' do
          user_updater.execute()
          related_documents.each do |document|
            if document.class == Request
              expect(document.user_sheet.outdated).to eq true
            elsif document.user_sheets.first == updated.user._id
              expect(document.user_sheets.first.outdated).to eq true
              #TODO: ¿necesario probar que no cambia la otra user sheet?
              #expect{ user_updater.execute() }.to_not change { document.user_sheets.last.outdated }
            else
              expect(document.user_sheets.last.outdated).to eq true
              #TODO: ¿necesario probar que no cambia la otra user sheet?
              #expect{ user_updater.execute() }.to_not change { document.user_sheets.first.outdated }
            end
          end
        end

        it 'outdates every related document' do
          user_updater.execute()
          related_documents.each do |document|
            expect(document.outdate).to eq true
          end
        end

        it 'calls save method for every related document' do
          related_documents.each do |document|
            expect(document).to receive(:save)
          end
          user_updater.execute()
        end

        it 'saves every related document' do
          user_updater.execute()
          related_documents.each do |document|
            expect(document).to be_persisted
          end
        end
      end

      context 'when there are not documents related to user' do
        #TODO: ¿comprobar que no hace lo de arriba?
      end
    end

    context 'when original_user does not exist' do
      it 'returns false' do
        expect(user_updater.execute()).to eq false
      end

      it 'does not call save method for user' do
        expect(user_updater.user).to_not receive(:save)
        user_updater.execute()
      end

      it 'does not save user' do
        user_updater.execute()
        expect(user_updater.user).to_not be_persisted
      end

      #TODO: Podrian eliminarse si no importa asegurarnos de que no hace llamadas que no deba
      it 'does not create an ObjectFinder instance' do
        expect(ObjectFinder).to_not receive(:new)
        user_updater.execute()
      end

      it 'does not call ObjectFinder.execute method' do
        expect_any_instance_of(ObjectFinder).to_not receive(:execute)
        user_updater.execute()
      end

      #TODO: comprobar que no hace lo de arriba (outdatear, salvar y eso)?
    end
  end
end
