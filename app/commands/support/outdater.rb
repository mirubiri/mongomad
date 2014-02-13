class Outdater
  def self.outdate(to_outdate=[])
    result = true
    to_outdate.each do |member|
      member.outdate
      result &&= member.outdated
    end
    result
  end
end
