Fabricator(:offer) do
  composer        { Fabricate.build(:offer_composer) }
  receiver        { Fabricate.build(:offer_receiver) }
  money           { Fabricate.build(:offer_money) }
  initial_message 'a long initial message to try the interface with a long text'

  after_build do |offer|

    #Añadir mas cosas aleatoriamente

    image_path='/images/rails.png'

    offer.composer.image=image_path
    offer.composer.products.each do |product|
      product.main_image=image_path
      product.secondary_images.each do |secondary_image|
        secondary_image.file=image_path
      end
    end

    offer.receiver.image=image_path
    offer.receiver.products.each do |product|
      product.main_image=image_path
      product.secondary_images.each do |secondary_image|
        secondary_image.file=image_path
      end
    end

  end
end
