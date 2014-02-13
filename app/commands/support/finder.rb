class Finder
  def self.find(object, collections=[])
    collections.each do |collection|
      collection.where(_id:object._id)
    end

    # result = true
    # to_save.each do |member|
    #   member.save
    #   result &&= member.persisted?
    # end
    # result
  end
  # busca el objeto
      # si es user en request, offer , negotiation y deal
      # si es item en user,negotiation, deal
  # devuelve un array con todos los objetos encontrados
end


# class Finder
#     raise StandardError, "given object is nil." unless object != nil
#     # raise StandardError, "collections array contains a non existent collection." unless to_outdate != []
#     raise StandardError, "collections array is empty." unless collections != []
#     raise StandardError, "collections array is nil." unless collections != nil
#     # raise StandardError, "given array is nil." unless to_outdate != nil

#   end

#   # busca el objeto
#       # si es user en request, offer , negotiation y deal
#       # si es item en user,negotiation, deal
#   # devuelve un array con todos los objetos encontrados
# end
# class Saver

# end
