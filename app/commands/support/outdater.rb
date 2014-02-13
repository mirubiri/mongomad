class Outdater
  def self.outdate(to_outdate=[])
    raise StandardError, "given array is nil." unless to_outdate != nil
    result = true
    to_outdate.each do |member|
      member.outdate
      result &&= member.outdated
    end
    result
  end
end
