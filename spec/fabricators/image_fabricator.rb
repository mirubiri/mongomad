Fabricator(:image_face, from: :"attachment/image") do
  id { %w(uploads/users/boy1_dark uploads/users/boy1_white uploads/users/boy2_dark uploads/users/boy2_white uploads/users/boy3_dark uploads/users/boy3_white uploads/users/boy4_dark uploads/users/boy4_white uploads/users/boy5_dark uploads/users/boy5_white uploads/users/girl1_dark uploads/users/girl1_white uploads/users/girl2_dark uploads/users/girl2_white uploads/users/girl3_dark uploads/users/girl3_white uploads/users/girl4_dark uploads/users/girl4_white uploads/users/girl5_dark uploads/users/girl5_white).sample }
  main true
end

Fabricator(:image_product, from: :"attachment/image") do
  id { %w(uploads/items/bicycle_dark uploads/items/bicycle_white uploads/items/car_dark uploads/items/car_white uploads/items/dog_dark uploads/items/dog_white uploads/items/house_dark uploads/items/house_white uploads/items/watch_dark uploads/items/watch_white).sample }
  main false
end

Fabricator(:image_money, from: :"attachment/image") do
 id { %w(uploads/cash/cash1 uploads/cash/cash2 uploads/cash/cash3 uploads/cash/cash4 uploads/cash/cash5).sample }
  main true
end
