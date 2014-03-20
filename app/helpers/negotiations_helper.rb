module NegotiationsHelper
  # Images
  def negotiation_composer_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 64, :height => 64, :crop => :fit, :radius => :max)
  end

  def negotiation_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 158, :height => 158, :crop => :fit)
  end

  def negotiation_composer_money_image
    cl_image_tag("static/images/money.png", :width => 158, :height => 158, :crop => :fit)
  end

  def negotiation_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 60, :height => 60, :crop => :fit)
  end

  def negotiation_receiver_money_image
    cl_image_tag("static/images/money.png", :width => 60, :height => 60, :crop => :fit)
  end

  def negotiation_message_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 30, :height => 30, :crop => :fit)
  end

  # Modal
  def negotiation_modal_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 50, :height => 50, :crop => :fit, :radius => :max)
  end

  def negotiation_modal_item_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 161, :height => 161, :crop => :fit)
  end

  def negotiation_modal_money_image
    cl_image_tag("static/images/money.png", :width => 161, :height => 161, :crop => :fit)
  end

  def negotiation_modal_composer_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 48, :height => 48, :crop => :fit)
  end

  def negotiation_modal_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 160, :height => 160, :crop => :fit)
  end

  def negotiation_modal_composer_money_image
    cl_image_tag("static/images/money.png", :width => 160, :height => 160, :crop => :fit)
  end

  def negotiation_modal_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 60, :height => 60, :crop => :fit)
  end

  def negotiation_modal_receiver_money_image
    cl_image_tag("static/images/money.png", :width => 60, :height => 60, :crop => :fit)
  end
end
