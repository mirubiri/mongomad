require 'spec_helper'

class Dummy
  include Mongoid::Document
  include ImageManagement::ImageHolder
end

describe ImageManagement::ImageHolder do

  let(:image_file) do
    ActionDispatch::Http::UploadedFile.new(filename:'car.png', conent_type:'image/png',tempfile:File.open('app/assets/images/car.png'))
  end

end