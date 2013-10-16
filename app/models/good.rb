class Good
  include Mongoid::Document
  include Attachment::Images
  
  embedded_in :proposal
end
