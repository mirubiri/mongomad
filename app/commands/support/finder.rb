class Finder
  def self.find(object, collections=[])
    matched_objects = Array.new
    if object.class == UserSheet
      collections.each do |collection|
        if collection == Request
          documents = collection.where("user_sheet._id" => object._id)
          documents.each do |document|
            matched_objects << document.user_sheet
          end
        else # collection != Request
          documents = collection.where("user_sheets._id" => object._id)
          documents.each do |document|
            matched_objects << document.user_sheets.where(_id:object._id).first
          end
        end
      end
    else # object.class != UserSheet
      collections.each do |collection|
        if collection == Offer
          documents = collection.where("proposal.goods._id" => object._id)
          documents.each do |document|
            matched_objects << document.proposal.goods.where(_id:object._id).first
          end
        else # collection.class != Offer
          documents = collection.where("proposals.goods._id" => object._id)
          documents.each do |document|
            matched_objects << document.proposals.last.goods.where(_id:object._id).first
          end
        end
      end
    end
    matched_objects
  end
end
