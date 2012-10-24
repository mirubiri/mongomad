Fabricator(:receiver) do
  offer
  after_build do |receiver|
    receiver.product_box = Fabricate(:product_box,polymorphic_product_box: receiver)
  end
end
