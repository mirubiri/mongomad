class ImageManagement::ImageManager

  def initialize(params)
    self.image_file=params[:file] || self.image_fingerprint = params[:fingerprint]
  end

  def store
    upload_new_image && create_metadata if image.nil?
    image
  end

  def destroy
    unless image.nil?
      decrease_image_use && true
    else
      false
    end
  end

  def algorithm
    Digest::SHA1
  end

  def db
    Image
  end

  def uploader
    @uploader ||= ImageManagement::ImageUploader.new
  end

  def increase_image_use
    image.references += 1
    image.save
    image
  end

  def decrease_image_use
    if image.references > 0
      image.references -= 1
      image.save
    end
    image
  end

  def image
    @image ||= db.where(fingerprint:image_fingerprint).first
  end

protected
  attr_accessor :image_file,:image_fingerprint
  attr_writer :image

  def image_fingerprint
    @image_fingerprint ||= algorithm.file(image_file.tempfile)
  end

  def upload_new_image
    uploader.store!(image_file)
  end

  def create_metadata
    self.image=db.create(fingerprint:image_fingerprint, url:uploader.url, references:0)
  end
end