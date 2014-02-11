class Saver
  def self.save(to_save=[])
    raise StandardError, "given array is empty" unless to_save != []
    raise StandardError, "given array is nil" unless to_save != nil
    to_save.each do |member|
      member.save
    end
    to_save
  end
end
