class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  include Attachment::Images

  embedded_in :user

  field :full_name
  field :gender
  field :language
  field :birth_date, type: Date
  field :location, type: Array

  def first_name
    full_name.split.take(1)[0]
  end

  def surnames
    full_name.split.drop(1).join(' ')
  end

  def main_image
    images.where(main:true).first || '/static/user_default'
  end
end
