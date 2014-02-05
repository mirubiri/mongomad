require 'spec_helper'

describe UserUpdater do
  # Variables
  let(:user) { Fabricate.build(:user_with_items) }
  let(:request) { Fabricate.build(:request, user:user) }
  let(:offer) { Fabricate.build(:offer, user_composer:user) }
  let(:negotiation) { Fabricate.build(:negotiation, offer:offer) }
  let(:deal) { Fabricate.build(:deal, negotiation:negotiation) }
  let(:updated_user) do
    user.nick = 'new_nick'
    user.profile.first_name = 'new_first_name'
    user.profile.images << Fabricate.build(:image_face, main:false)
    user.profile.set_main_image(user.profile.images.last._id)
    user
  end

  # Methods
  describe '#execute' do
    context 'when user exists' do
      before(:each) { user.save }

      it 'returns true' do
        expect(execute(updated_user)).to eq true
      end

      it 'updates user data' do
        execute(updated_user)
        expect(User.find(user._id)).to eq updated_user
      end

      it 'calls save method' do
        expect(user).to receive(:save)
        execute(updated_user)
      end

      it 'calls ObjectFinder.execute method with user' do
        expect(ObjectFinder).to receive(:execute).with(user)
        execute(updated_user)
      end

      context 'when there are documents related to user' do
        before(:each) do
          request.save
          offer.save
          negotiation.save
          deal.save
        end

        #TODO: Usar stubs declarando las variables devueltas (darle una vuelta)
        let(:related_documents) { ObjectFinder.execute(user) }
        let(:outdated_documents) { ObjectOutdaterDecorator.new(related_documents) }
        let(:outdated_parents) { ParentsOutdaterDecorator.new(outdated_documents) }

        it 'calls ObjectOutdaterDecorator.new method with related_documents' do
          expect(ObjectOutdaterDecorator).to receive(:new).with(related_documents)
          execute(updated_user)
        end

        it 'calls outdate_objects method with user' do
          expect_any_instance_of(ObjectOutdaterDecorator).to receive(:outdate_objects).with(user)
          execute(updated_user)
        end

        it 'calls ParentsOutdaterDecorator.new method with outdate_objects' do
          expect(ParentsOutdaterDecorator).to receive(:new).with(outdate_objects)
          execute(updated_user)
        end

        it 'calls outdate_parents method with user' do
          expect_any_instance_of(ParentsOutdaterDecorator).to receive(:outdate_parents).with(user)
          execute(updated_user)
        end

        it 'calls ArraySaverDecorator.new method with outdate_objects' do
          expect(ArraySaverDecorator).to receive(:new).with(outdate_parents)
          execute(updated_user)
        end

        it 'calls save_all method' do
          expect_any_instance_of(ArraySaverDecorator).to receive(:save_all)
          execute(updated_user)
        end
      end

      context 'when there are not documents related to user' do
        it 'does not call ObjectOutdaterDecorator.new method' do
          expect(ObjectOutdaterDecorator).to_not receive(:new)
          execute(updated_user)
        end

        it 'does not call outdate_objects method' do
          expect_any_instance_of(ObjectOutdaterDecorator).to_not receive(:outdate_objects)
          execute(updated_user)
        end

        it 'does not call ParentsOutdaterDecorator.new method' do
          expect(ParentsOutdaterDecorator).to receive(:new)
          execute(updated_user)
        end

        it 'does not call outdate_parents method' do
          expect_any_instance_of(ParentsOutdaterDecorator).to receive(:outdate_parents)
          execute(updated_user)
        end

        it 'does not call ArraySaverDecorator.new method' do
          expect(ArraySaverDecorator).to receive(:new)
          execute(updated_user)
        end

        it 'does not call save_all method' do
          expect_any_instance_of(ArraySaverDecorator).to receive(:save_all)
          execute(updated_user)
        end
      end
    end

    context 'when user does not exist' do
      it 'returns false' do
        expect(execute(updated_user)).to eq false
      end

      it 'does not call save method' do
        expect_any_instance_of(User).to_not receive(:save)
        execute(updated_user)
      end

      it 'does not call ObjectFinder.execute method' do
        expect(ObjectFinder).to_not receive(:execute)
        execute(updated_user)
      end

      it 'does not call ObjectOutdaterDecorator.new method' do
        expect(ObjectOutdaterDecorator).to_not receive(:new)
        execute(updated_user)
      end

      it 'does not call outdate_objects method' do
        expect_any_instance_of(ObjectOutdaterDecorator).to_not receive(:outdate_objects)
        execute(updated_user)
      end

      it 'does not call ParentsOutdaterDecorator.new method' do
        expect(ParentsOutdaterDecorator).to receive(:new)
        execute(updated_user)
      end

      it 'does not call outdate_parents method' do
        expect_any_instance_of(ParentsOutdaterDecorator).to receive(:outdate_parents)
        execute(updated_user)
      end

      it 'does not call ArraySaverDecorator.new method' do
        expect(ArraySaverDecorator).to receive(:new)
        execute(updated_user)
      end

      it 'does not call save_all method' do
        expect_any_instance_of(ArraySaverDecorator).to receive(:save_all)
        execute(updated_user)
      end
    end
  end
end
