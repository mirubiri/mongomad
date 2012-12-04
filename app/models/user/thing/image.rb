class User::Thing::Image
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :thing, class_name: "User::Thing"

  has_mongoid_attached_file :file

  validates :thing,
            :file,
            presence: true
end