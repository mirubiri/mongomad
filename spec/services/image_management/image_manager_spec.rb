require 'spec_helper'

describe ImageManagement::ImageManager do
  let(:image_file) do
    ActionDispatch::Http::UploadedFile.new(filename:'car.png', conent_type:'image/png',tempfile:File.open('app/assets/images/car.png'))
  end
  let(:manager) { ImageManagement::ImageManager.new(file:image_file) }

  before(:each) { manager.db.destroy_all }

  describe '#store' do

    context 'When given an image file' do
      context 'which is not previously stored' do

        it 'uploads the image file' do
          manager.uploader.should_receive(:store!).with(image_file)
          manager.store
        end

        it 'saves the image metadata' do
          manager.uploader.stub(:url).and_return('url')
          manager.algorithm.stub(:file).and_return('fingerprint')

          params={fingerprint:'fingerprint',url:'url',references:0}
          manager.db.should_receive(:create).with(params)
          manager.store
        end

      end

      context 'which is previously stored' do
        before(:each) { manager.store }

        it 'do not upload the image file' do
          manager.uploader.should_not_receive(:store!)
          manager.store
        end

        it 'do not creates a new register in image metadata database' do
          expect { manager.store }.to_not change { manager.db.count }
        end

      end

      it 'returns the image' do
        expect(manager.store).to eq manager.image
      end
    end

    context 'When given image fingerprint' do
      context 'and image corresponding to fingerprint is not stored' do
        it 'returns nil' do
          manager=ImageManagement::ImageManager.new(fingerprint:'unexistent')
          expect(manager.store).to eq nil
        end
      end

      context 'and image corresponding to fingerprint is stored' do
        before(:each) { manager.store }
        let(:fingermanager) { ImageManagement::ImageManager.new(fingerprint:manager.image[:fingerprint]) }

        it 'returns the image' do
          expect(fingermanager.store).to eq fingermanager.image
        end
      end
    end


    context "When given file cannot be uploaded" do

      it 'do not saves the image metadata' do
        manager.uploader.should_receive(:store!).with(image_file).and_raise('CarrierWave::UploadError')
        expect  { manager.store rescue CarrierWave::UploadError }.to_not change { manager.db.count }
      end
    end
  end


  describe '#destroy' do

    it 'decreases the image references count by 1' do
      manager.store
      manager.should_receive(:decrease_image_use)
      manager.destroy
    end

    it 'returns true if image file is stored' do
      manager.store
      expect(manager.destroy).to eq true
    end

    it 'returns false if image file is not stored' do
      expect(manager.destroy).to eq false
    end

  end

  describe '#image' do
    it 'returns the image metadata' do
      manager.store
      expect(manager.image).to eq manager.db.where(fingerprint:manager.image.fingerprint).first
    end
  end

  describe '#increase_image_use' do
    it 'increases the image references count by 1 if image file is stored' do
      manager.store
      expect{manager.increase_image_use}.to change { manager.db.where(fingerprint:manager.image.fingerprint).first.references}.by(1)
    end

    xit 'returns nil if image_file is not stored' do
    end
  end

  describe '#decrease_image_use' do
    context 'When file is stored' do
      it 'decreases the image references count by 1' do
        manager.store
        manager.increase_image_use
        expect { manager.decrease_image_use }.to change { manager.db.where(fingerprint:manager.image.fingerprint).first.references }.by(-1)
      end

      it 'do not decreases the image references below 0' do
        manager.store
        expect { manager.decrease_image_use }.to_not change { manager.db.where(fingerprint:manager.image.fingerprint).first.references }
      end
    end

    xit 'returns nil if image_file is not stored' do
    end

  end
end
