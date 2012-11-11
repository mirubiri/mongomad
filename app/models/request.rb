class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user

  field :text, type: String

  validates :user,
            :text,
            presence: true

  def publish
    self.save
  end
end