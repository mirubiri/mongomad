 module ApplicationHelper
  def agreement(object)
    object.agreement
  end

  def birth_date(object)
    object.profile.birth_date
  end

  def composer(object)
    object.composer
  end

  def composer_products(object)
    products(object, object.composer)
  end

  def date_time(object)
    object.created_at
  end

  def deals(object)
    object.deals
  end

  def description(object)
    object.description
  end

  def first_name(object)
    if object.class == User
      object.profile.first_name
    else
      object.first_name
    end
  end

  def full_name(object)
    first_name(object) + last_name(object)
  end

  def gender(object)
    object.profile.gender
  end

  def id(object)
    object._id
  end

  def images(object)
    if object.class == User
      object.profile.images
    elsif object.class == Request
       object.user_sheet.images
    else
       object.images
    end
  end

  def items(object)
    User.find(object._id).items
  end

  def language(object)
    object.profile.language
  end

  def last_name(object)
    if object.class == User
      object.profile.last_name
    else
      object.last_name
    end
  end

  def location(object)
    if object.class == User
      object.profile.location
    else
      object.location
    end
  end

  def main_image(object)
    if object.class == User
      cl_image_tag(object.profile.main_image._id + ".jpg")
    elsif object.class == Request
      cl_image_tag(object.user_sheet.main_image._id + ".jpg")
    else
      cl_image_tag(object.main_image._id + ".jpg")
    end
  end

  def message(object)
    if object.class == Offer
      object.message
    else
      object.messages.last
    end
  end

  def messages(object)
    object.messages
  end

  def name(object)
    object.name
  end

  def negotiations(object)
    object.negotiations
  end

  def nick(object)
    object.nick    
  end  

  def products(object, user)
    if object.class == Offer
       object.proposal.products(user._id)
     else
       object.products(user.id)
     end
  end

  def proposal(object)
    object.proposal
  end

  def proposals(object)
    object.proposals
  end

  def quantity(object)
    object.quantity
  end

  def received_offers(object)
    object.received_offers
  end

  def receiver(object)
    object.receiver
  end

  def receiver_products(object)
    products(object, object.receiver)
  end

  def requests(object)
    object.requests
  end

  def sent_offers(object)
    object.sent_offers
  end

  def state(object)
    object.state
  end

  def stock(object)
    object.stock
  end

  def text(object)
    object.text
  end
end
