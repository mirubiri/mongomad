class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Attachment::Images
  include Ownership

  ownership :single

  field :name
  field :description

  def to_product
    Product.new(name:name, description:description, user_id:user_id, images:images) do |product|
      product.id = id
    end
  end

  def withdraw
  end

  def sell
  end

  def hide
  end
end
