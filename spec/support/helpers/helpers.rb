module MongomadHelpers
  private
  def attributes_for_offerable(offerable)
    {
      user_composer_id: offerable.user_composer_id,
      user_receiver_id: offerable.user_receiver_id,
      composer_things:  offerable.composer.products.map do |product|
        { thing_id: product[:thing_id], quantity: product[:quantity] }
      end,
      receiver_things:  offerable.receiver.products.map do |product|
        { thing_id: product[:thing_id], quantity: product[:quantity] }
      end,
      money: { user_id: offerable.money.user_id, quantity: offerable.money.quantity }
    }
  end

  public
  def params_for_offer(offer)
    hash=attributes_for_offer(offer)
    hash.delete(:user_composer_id)
    hash
  end

  def attributes_for_offer(offer)
    hash=attributes_for_offerable(offer)
    hash[:initial_message]=offer.initial_message
    hash
  end


  def attributes_for_request(request)
    {
      user_id: request.user_id,
      user_name: request.user_name,
      text: request.text,
      image_name:request.image_name
    }
  end

  def params_for_request(request)
    {
      text:request.text
    }
  end

  def params_for_thing(thing)
    hash=attributes_for_thing(thing)
    hash.delete(:user_id)
    hash
  end

  def attributes_for_thing(thing)
    {
      name: thing.name,
      description: thing.description,
      stock: thing.stock,
      image_name: thing.image_name
    }
  end

  alias_method :params_for_proposal, :attributes_for_offerable
end
