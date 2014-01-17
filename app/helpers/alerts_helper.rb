module AlertsHelper
  def agreement(object)
    objetc.agreement
  end

  def birth_date(object)
    objetc.profile.birth_date
  end

  def composer(object)
    object.composer
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
    objetc.profile.gender
  end

  def id(object)
    object._id
  end

  def images(object)
    if object.class == User
      object.profile.images
    else
      object.images
    end
  end

  def language(object)
    objetc.profile.language
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
      object.profile.main_image
    else
      object.main_image
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

  def nick(object)
      object.nick
    end
  end

  def products(object, user)
    if object.class == Offer
       object.proposal.products(user._id)
     else
       object.products(user_id)
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

  def receiver(object)
    object.receiver
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
