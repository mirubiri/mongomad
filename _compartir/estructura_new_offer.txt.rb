def crear_oferta
puts 'numero de ofertas antes'
puts Offer.count
user=Fabricate(:user_with_things)
puts 'creando oferta'

o=Offer.new(
  composer:Offer::Composer.new(
    user_id:user._id,
    name:'user_name',
    products:[Offer::Composer::Product.new(
      thing_id:'thing_id',
      name:'name',
      description:'description',
      main_image:'ruta_imagen',
      images:[Offer::Composer::Product::Image.new(
        file:'ruta_imagen'
      )],
    )],
    image:'ruta_imagen',
  ),
  receiver:Offer::Receiver.new(
    user_id:user._id,
    name:'user_name',
    products:[Offer::Receiver::Product.new(
      thing_id:'thing_id',
      name:'name',
      description:'description',
      main_image:'ruta_imagen',
      images:[Offer::Receiver::Product::Image.new(
        file:'ruta_imagen'
      )],
    )],
    image:'ruta_imagen',
  ),
  money:Offer::Money.new(
    user_id:user._id,
    quantity:2000
  ),
  initial_message:'initial_message'
)

o.save
puts 'numero de ofertas despues'
puts Offer.count
end