class OneCashPolicy
  def self.valid?(array)
    result= array.map { |element| element if element._type="cash" }
    result.size <= 1
  end
end
