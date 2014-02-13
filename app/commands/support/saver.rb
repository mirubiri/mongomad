class Saver
  def self.save(to_save=[])
    raise StandardError, "given array is nil." unless to_save != nil
    result = true
    to_save.each do |member|
      raise StandardError, "given array contains a no valid member." unless member.valid?
      member.save
      result &&= member.persisted?
    end
    result
  end
end
