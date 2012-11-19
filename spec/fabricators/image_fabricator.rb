Fabricator(:image) do
  #polymorphic_image nil
  file File.open('app/assets/images/rails.png')
end
