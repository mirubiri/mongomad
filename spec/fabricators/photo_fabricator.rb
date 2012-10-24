Fabricator(:photo) do
  photo File.open('app/assets/images/rails.png')
end