class Outdater

   def self.outdate(to_outdate=[])
    to_outdate.each do |member|
      member.outdate
    end
   end

end
