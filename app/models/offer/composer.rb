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
        raise "quantity is not correct" if (params[:quantity] == nil  || params[:quantity] < 0 || params[:quantity] > thing.stock)

        products.build(thing_id: params[:thing_id], quantity: params[:quantity])
      end
    end
    persisted? ? save : self
  end

  def alter_contents(products_params)
    products.destroy
    add_products(products_params)
  end

  #private
  # def update_user_data
  #   raise "user is not valid" if (offer.user_composer == nil || offer.user_composer.persisted? == false)
  #   reload if persisted?
  #   self.name = offer.user_composer.profile.name
  #   self.image_name = offer.user_composer.profile.image_name
  # end

  # def update_products
  #   products.each do |product|
  #     product.self_update!
  #   end
  # end

  def self_update!
    raise "user is not valid" if (offer.user_composer == nil || offer.user_composer.persisted? == false)
      # reload if persisted?
      self.name = offer.user_composer.profile.name
      self.image_name = offer.user_composer.profile.image_name

      products.each do |product|
        product.self_update!
      end

    # update_user_data
    # update_products
     #persisted? ? save : self
  end
end
