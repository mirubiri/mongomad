class Offer::Composer
  include Mongoid::Document

  embedded_in :offer
  embeds_many :products, class_name: "Offer::Composer::Product", cascade_callbacks: true

  field :name, type: String

  mount_uploader :image, ProductImageUploader, :mount_on => :image_name

  validates :offer,
    :products,
    :name,
    :image_name,
    presence: true

  def add_products(products_params)
    products_params.each do |params|
      if params.has_key?(:thing_id) && params.has_key?(:quantity)
        users = User.where('things._id' => Moped::BSON::ObjectId(params[:thing_id]))
        raise "thing is not valid" unless users.count == 1
        user = users.first

        things = user.things.where('_id' => Moped::BSON::ObjectId(params[:thing_id]))
        raise "thing is not valid" unless things.count == 1
        thing = things.first

        raise "owner thing is not correct" unless offer.user_composer._id == thing.user._id
        raise "quantity is not correct" if (params[:quantity] < 0 || params[:quantity] > thing.stock)

        products.build(thing_id: params[:thing_id], quantity: params[:quantity])
      end
    end
    self.persisted? ? self.save : self
  end

  def alter_contents(products_params)
    # products.destroy
    # add_products(products_params)
  end

  def self_update!
  end



=begin
 NO TOCAR, el lunes lo elimino yo :)


  def update_user_data
    # raise "user is not valid" if (offer.user_composer == nil || offer.user_composer.persisted? == false)
    # reload if persisted?
    # self.name = offer.user_composer.profile.name
    # self.image_name = offer.user_composer.profile.image_name
  end

  def update_products
    # products.each do |product|
    #   product.self_update!
    # end
  end

  def self_update!
    puts "updateao"
    # update_user_data
    # update_products

# raise "user is not valid" if (offer.user_composer == nil  || offer.user_composer.persisted? == false)
    reload if persisted?
    self.name = offer.user_composer.profile.name
    self.image_name = offer.user_composer.profile.image_name
    products.each do |product|
       product.self_update!
    end

     persisted? ? save : self
  end





  # users = User.where('things._id' => Moped::BSON::ObjectId(self.thing_id))
  #   raise "thing is not valid" unless users.count == 1
  #   user = users.first

  #   things = user.things.where('_id' => Moped::BSON::ObjectId(self.thing_id))
  #   raise "thing is not valid" unless things.count == 1
  #   thing = things.first

  #   raise "owner thing is not correct" unless composer.offer.user_composer._id == thing.user._id
  #   raise "quantity is not correct" if (self.quantity < 0 || self.quantity > thing.stock)

  #   reload if persisted?
  #   self.name = thing.name
  #   self.description = thing.description
  #   self.image_name = thing.image_name
  #   persisted? ? save : self



  #    # composer_things = offer.user_composer.things
  #   products_params.each do |product|
  #     # thing = composer_things.find(product[:thing_id])
  #     # raise "thing is not valid" if thing == nil
  #     # raise "quantity is not valid" if thind.quantity < product[:quantity]
  #     products.build(thing_id: product[:thing_id], quantity: product[:quantity])
  #   end
  #   self.self_update!




=begin

  def update_user_data
    reload if persisted?
    self.name = offer.user_composer.profile.name
    self.image_name = offer.user_composer.profile.image_name
  end

  def update_products
    products.each do |product|
      product.self_update!
    end
  end

  def self_update!
    update_user_data
    update_products
    persisted? ? save : self
  end

  def add_products(products_params=[])
    # composer_things = offer.user_composer.things
    products_params.each do |product|
      # thing = composer_things.find(product[:thing_id])
      # raise "thing is not valid" if thing == nil
      # raise "quantity is not valid" if thind.quantity < product[:quantity]
      products.build(thing_id: product[:thing_id], quantity: product[:quantity])
    end
    self.self_update!
  end



  def alter_contents(params=[])
    products.destroy
    add_products(params)
  end



  public
=end
end
