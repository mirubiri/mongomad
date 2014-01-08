class Good
  include Mongoid::Document
  include Mongoid::Timestamps
  include Attachment::Images

  embedded_in :proposal
end
