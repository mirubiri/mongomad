Fabricator(:product_box) do
  polymorphic_product_box(fabricator: :receiver)
  after_build do |product_box|
    product_box.products=[ Fabricate(:product, product_box: product_box) ]
  end
end
