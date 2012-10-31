Fabricator(:composer) do
  offer
  after_build do |composer|
    composer.product_box = Fabricate(:product_box, polymorphic_product_box: composer)
  end
end