class Outdater
  def self.outdate(to_outdate=[])
    raise StandardError, "given array is empty" unless to_outdate != []
    raise StandardError, "given array is nil" unless to_outdate != nil
    to_outdate.each do |member|
      member.outdate
    end
    to_outdate
  end
end
