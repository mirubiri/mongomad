class Saver
  def self.save(to_save=[])
    result = true
    to_save.each do |member|
      member.save
      result &&= member.persisted?
    end
    result
  end
end
