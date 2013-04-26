require 'spec_helper'

describe ImageManagement::ImageManager do
  let(:manager) { ImageManagement::ImageManager }
  let(:algorithm) { manager.class_variable_get(:@@algorithm) }
  let(:metadata_model) { manager.class_variable_get(:@@metadata_model) }
  let(:uploader) { manager.class_variable_get(:@@image_uploader) }
  let(:uploader_instance) { uploader.new }

  let(:image_file) { File.open('app/assets/images/sergio.jpg') }
  let(:image_hash) { algorithm.file(image_file) }

  before(:each) { metadata_model.destroy_all }


  describe '.store' do

    context 'When given an image file' do
      context 'which is not previously stored' do

        it 'uploads the image file' do
          uploader.any_instance.should_receive(:store!).with(image_file)
          manager.store(image_file:image_file)
        end

        it 'saves the image metadata' do
          uploader_instance.store!(image_file)
          params={hash:algorithm.file(image_file),url:uploader_instance.url,references:0}
          metadata_model.should_receive(:create).with(params)
          manager.store(image_file:image_file)
        end

        it 'returns the generated image url' do
          uploader_instance.store!(image_file)
          expect(manager.store(image_file:image_file)).to eq uploader_instance.url
        end
      end

      context 'which is previously stored' do
        before(:each) { manager.store(image_file:image_file) }

        it 'do not upload the image file' do
          uploader.any_instance.should_not_receive(:store!).with(image_file)
          manager.store(image_file:image_file)
        end

        it 'do not creates a new register in image metadata database' do
          expect { manager.store(image_file:image_file) }.to_not change { metadata_model.count }
        end

        it 'increases the image referenced count by 1' do
          expect { manager.store(image_file:image_file) }.to change{ metadata_model.where(hash:image_hash).first.references }.by(1)
        end

        it 'returns the previously stored image url' do
          expect(manager.store(image_file:image_file)).to eq metadata_model.where(hash:image_hash).first.url
        end
      end
    end



    context 'When given a hash in :image_hash param' do
      context 'When :image_hash is not stored' do
        it 'raise exception' do
        end
      end

      context 'When :image_hash is stored' do
        before(:each) { manager.store(image_file:image_file) }

        it 'increases the image references count by 1' do
          expect { manager.store(image_hash:image_hash) }.to change{ metadata_model.where(hash:image_hash).first.references }.by(1)
        end
      end
    end

=begin
    context "When given file cannot be uploaded" do
      before(:each) { uploader.any_instance.should_receive(:store!).with(image_file).and_return(nil) }

      it 'do not saves the image metadata' do
        expect { manager.store(image_file:image_file) }.to_not change { metadata_model.count }
      end

      it 'returns nil' do
        expect(manager.store(image_file:image_file)).to eq nil
      end
    end

    context "When metadata could not be stored or updated" do
      before(:each) do
        metadata_model.stub(:create).and_return(false)
        metadata_model.any_instance.stub(:save).and_return(false)
      end

      it 'returns nil' do
        expect { manager.store(image_file:image_file) }.to eq nil
        expect { manager.store(image_hash:image_hash) }.to eq nil
      end
    end
  end

  describe '.destroy' do
    context 'When the image file is stored' do
      before(:each) { manager.store(image_file:image_file) }

      it 'decreases the image references count by 1' do
        expect { manager.destroy }.to change { metadata_model.where(hash:image_hash).first.references }.by(-1)
      end

      it 'returns the resultant image references count' do
        expect(manager.destroy).to eq metadata_model.where(hash:image_hash).first.references
      end
    end

    context 'When the image file is not stored' do
      it 'returns false' do
        expect(manager.destroy).to eq false
      end
    end
  end
=end
end
end
