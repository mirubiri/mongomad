class ImageManagement::ImageManager

  def initialize(params)
    self.image_file=params[:file] || self.image_hash = params[:hash]
  end

  def store!
    if image_metadata.nil?
      upload_new_image && create_metadata
    else
      increase_image_use
    end
    image_metadata
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


  private

  attr_accessor :image_file

  def uploader
    @uploader ||= uploader_service.new
  end


  def image_hash
    @image_hash ||= algorithm.file(image_file)
  end

  def image_hash=(image_hash)
    @image_hash = image_hash
  end


  def image_metadata
    @image_metadata ||= db.where(hash:image_hash).first
  end

  def image_metadata=(image_metadata)
    @image_metadata = image_metadata
  end


  def upload_new_image
    uploader.store!(@image_file)
  end

  def create_metadata
    self.image_metadata=db.create(hash:image_hash,url:uploader.url,references:0)
  end

  def increase_image_use
    image_metadata.references+=1
    image_metadata.save
    image_metadata
  end
end