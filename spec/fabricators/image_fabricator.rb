Fabricator(:image_face, from: :"attachment/image") do
  id { %w(boy1_dark, boy1_white, boy2_dark, boy2_white, boy3_dark, boy3_white, boy4_dark, boy4_white, boy5_dark, boy5_white, girl1_dark, girl1_white, girl2_dark, girl2_white, girl3_dark, girl3_white, girl4_dark, girl4_white, girl5_dark, girl5_white).sample }
  main true
end

Fabricator(:image_product, from: :"attachment/image") do
  id { %w(bicycle_dark, bicycle_white, car_dark, car_white, dog_dark, dog_white, house_dark, house_white, watch_dark, watch_white).sample }
  main false
end

Fabricator(:image_money, from: :"attachment/image") do
 id { %w(cash1, cash2, cash3, cash4, cash5).sample }
  main true
end
