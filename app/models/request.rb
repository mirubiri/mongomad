class Request
  include Mongoid::Document
  include Mongoid::Timestamps
  include Ownership

  ownership :single

  field :text
end
