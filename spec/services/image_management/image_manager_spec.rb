require 'spec_helper'

describe ImageManagement::ImageManager do
  let(:image_file) { File.open('app/assets/images/sergio.jpg') }
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

          params={fingerprint:'fingerprint',url:'url',references:1}
          manager.db.should_receive(:create).with(params)
          manager.store
        end

        it 'returns the generated image metadata ' do
          manager.uploader.stub(:url).and_return('url')
          manager.algorithm.stub(:file).and_return('fingerprint')
          manager.store
          expect(manager.image).to include(fingerprint:'fingerprint',url:'url',references:1)
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

        it 'increases the image referenced count by 1' do
          expect { manager.store }.to change{ manager.db.where(fingerprint:manager.image[:fingerprint]).first.references }.by(1)
        end

        it 'returns the previously stored image metadata' do
          existing_metadata=manager.db.where(fingerprint:manager.image[:fingerprint]).first

          expect(manager.image).to include(fingerprint:existing_metadata.fingerprint,
            url:existing_metadata.url,
            references:existing_metadata.references)
        end
      end
    end

    context 'When given image fingerprint' do
      context 'and image corresponding to fingerprint is not stored' do
        it 'raise exception' do
        end
      end

      context 'and image corresponding to fingerprint is stored' do
        before(:each) { manager.store }
        let(:fingermanager) { ImageManagement::ImageManager.new(fingerprint:manager.image[:fingerprint]) }

        it 'increases the image references count by 1' do

          expect { fingermanager.store }.to change{ fingermanager.db.where(fingerprint:fingermanager.image[:fingerprint]).first.references }.by(1)
        end
      end
    end


    context "When given file cannot be uploaded" do
      before(:each) { uploader.any_instance.should_receive(:store!).with(image_file).and_return(nil) }

      xit 'do not saves the image metadata' do
        expect { manager.store(image_file:image_file) }.to_not change { metadata_model.count }
      end

      xit 'returns nil' do
        expect(manager.store(image_file:image_file)).to eq nil
      end
    end

    context "When metadata could not be stored or updated" do
      before(:each) do
        metadata_model.stub(:create).and_return(false)
        metadata_model.any_instance.stub(:save).and_return(false)
      end

      xit 'returns nil' do
        expect { manager.store(image_file:image_file) }.to eq nil
        expect { manager.store(image_hash:image_hash) }.to eq nil
      end
    end
  end


  describe '#destroy' do
    context 'When the image file is stored' do
      context 'and not given a number' do
        it 'decreases the image references count by 1' do
          manager.store
          expect { manager.destroy }.to change { manager.db.where(fingerprint:manager.image[:fingerprint]).first.references }.by(-1)
        end
      end

      context 'and given a number' do
        it 'decreases the image references count by number' do
          10.times { manager.store }
          expect { manager.destroy(5) }.to change { manager.db.where(fingerprint:manager.image[:fingerprint]).first.references }.by(-5)
        end
      end

      context 'and given a number greater than the stored references' do
        it 'decreases the image references to 0' do
          10.times { manager.store }
          expect { manager.destroy(15) }.to change { manager.db.where(fingerprint:manager.image[:fingerprint]).first.references }.by(-10)
        end
      end

      it 'returns the stored image metadata' do
        manager.store
        manager.destroy
        existing_metadata=manager.db.where(fingerprint:manager.image[:fingerprint]).first

        expect(manager.image).to include(fingerprint:existing_metadata.fingerprint,
          url:existing_metadata.url,
          references:existing_metadata.references)
      end

    end

    context 'When the image file is not stored' do
      xit 'returns false' do
        expect(manager.destroy).to eq false
      end
    end
  end
end
