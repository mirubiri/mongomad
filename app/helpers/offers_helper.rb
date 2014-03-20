module OffersHelper
  # Static
  def initial_message_icon
    cl_image_tag("static/icons/initial_message.png", :width => 50, :height => 50, :crop => :fit)
  end

  # Images
  def offer_composer_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 48, :height => 48, :crop => :fit, :radius => :max)
  end

  def offer_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 158, :height => 158, :crop => :fit)
  end

  def offer_composer_money_image
    cl_image_tag("static/images/money.png", :width => 158, :height => 158, :crop => :fit)
  end

  def offer_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 60, :height => 60, :crop => :fit)
  end

  def offer_receiver_money_image
    cl_image_tag("static/images/money.png", :width => 60, :height => 60, :crop => :fit)
  end

  # Modal
  def offer_modal_user_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 50, :height => 50, :crop => :fit, :radius => :max)
  end

  def offer_modal_item_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 161, :height => 161, :crop => :fit)
  end

  def offer_modal_money_image
    cl_image_tag("static/images/money.png", :width => 161, :height => 161, :crop => :fit)
  end

  def offer_modal_composer_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 48, :height => 48, :crop => :fit)
  end

  def offer_modal_composer_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 160, :height => 160, :crop => :fit)
  end

  def offer_modal_composer_money_image
    cl_image_tag("static/images/money.png", :width => 160, :height => 160, :crop => :fit)
  end

  def offer_modal_receiver_product_image(object)
    cl_image_tag(id(main_image(object)) + ".jpg", :width => 60, :height => 60, :crop => :fit)
  end

  def offer_modal_receiver_money_image
    cl_image_tag("static/images/money.png", :width => 60, :height => 60, :crop => :fit)
  end
end
