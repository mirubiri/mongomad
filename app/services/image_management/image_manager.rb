class ImageManagement::ImageManager

  def initialize(params)
    self.image_file=params[:file] || self.image_fingerprint = params[:fingerprint]
  end

  def store
    if image_metadata.nil?
      upload_new_image && create_metadata
    else
      increase_image_use
    end
    image
  end

  def image
    {
      url: image_metadata.try(:url),
      fingerprint: image_metadata.try(:fingerprint),
      references: image_metadata.try(:references)
    }
  end

  def reload
    self.image_metadata=nil
  end

  def destroy
    if image_metadata
      decrease_image_use
    end
    image
  end

  def algorithm
    Digest::SHA1
  end

  def db
    Image
  end

  def uploader_service
    ImageManagement::ImageUploader
  end

protected
  attr_accessor :image_file,:image_fingerprint,:image_metadata

  def uploader
    @uploader ||= uploader_service.new
  end

  def image_fingerprint
    @image_fingerprint ||= algorithm.file(image_file)
  end

  def image_metadata
    @image_metadata ||= db.where(fingerprint:image_fingerprint).first
  end

  def upload_new_image
    uploader.store!(@image_file)
  end

  def create_metadata
    self.image_metadata=db.create(fingerprint:image_fingerprint,url:uploader.url,references:1)
  end

  def increase_image_use
    image_metadata.references+=1
    image_metadata.save
    image_metadata
  end

  def decrease_image_use
    if image_metadata.references > 0
      image_metadata.references-=1
      image_metadata.save
    end
    image_metadata
  end
end