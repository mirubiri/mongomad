module ApplicationHelper

  def user_logged_name(user = user_logged)
    user.profile.name
  end

  def user_logged_surname(user = user_logged)
    user.profile.surname
  end

  def user_logged_image(user = user_logged)
    image_tag(user.profile.image)
  end

  def user_logged_things(user = user_logged)
    user.things
  end

  def user_logged_id(user = user_logged)
    user._id
  end

  def user_logged_negotiations(user = user_logged)
    user.negotiations
  end

  def user_logged_country(user = user_logged)
    user.profile.country
  end



  def user_visited_name
    @user.profile.name
  end

  def user_visited_nickname
    @user.profile.nickname
  end

  def user_visited_birthdate
    @user.profile.birth_date
  end

  def user_visited_country
    @user.profile.country
  end

  def user_visited_phone
    @user.profile.phone_number
  end

  def user_visited_image
    image_tag(@user.profile.image)
  end

  def user_visited_things
    @user.things
  end

  def user_visited_offers
    @user.received_offers
  end

  def user_visited_id
    @user._id
  end



  def thing_image(thing)
    image_tag(thing.image)
  end

  def thing_id(thing)
    thing._id
  end

  def thing_name(thing)
    thing.name
  end

  def thing_description(thing)
    thing.description
  end



  def negotiation_composer_image(negotiation)
    image_tag(negotiation.proposals.last.composer.image)
  end

  def negotiation_composer_products(negotiation)
    negotiation.proposals.last.composer.products
  end

  def negotiation_receiver_image(negotiation)
    image_tag(negotiation.proposals.last.receiver.image)
  end

  def negotiation_receiver_products(negotiation)
    negotiation.proposals.last.receiver.products
  end



  def product_image(product)
    image_tag(product.image)
  end

  def product_name(product)
    product.name
  end

  def product_description(product)
    product.description
  end



  def request_image(request)
    image_tag(request.image)
  end

  def request_text(request)
    request.text
  end

  def request_id(request)
    request._id
  end



  def offer_id(offer)
    offer._id
  end

  def offer_composer_image(offer)
    image_tag(offer.composer.image)
  end

  def offer_composer_products(offer)
      offer.composer.products
  end

  def offer_composer_id(offer)
    offer.user_composer_id
  end

  def offer_receiver_products(offer)
      offer.receiver.products
  end

  def offer_message(offer)
    offer.initial_message
  end


end
