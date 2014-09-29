class ItemRetirer
  attr_accessor :id_list
  
  def initialize(id_list)
    self.id_list=id_list
  end

  def retire
  	products.each do |product|
  		product.update_attributes(retired:true)
  	end
  end

  private

  def products
  	@products ||= ProductQuery.find(id_list)
  end
  
end
