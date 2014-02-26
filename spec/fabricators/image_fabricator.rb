Fabricator(:image_face, from: :"attachment/image") do
  id { %w(skzrrjmmxvrkavyktpqb esbuzqkoz0jt815cmcnz zlc3p5qoxg1h2ni4ntlo p1nintszjipizakntewc cara4_eddrkb cara1_khux83 cara3_pbobew cara_2_pkup80).sample }
  main true
end

Fabricator(:image_product, from: :"attachment/image") do
  id { %w(skzrrjmmxvrkavyktpqb esbuzqkoz0jt815cmcnz zlc3p5qoxg1h2ni4ntlo p1nintszjipizakntewc product6_yrwcdq product5_asmr05 product2_cvlckt product4_dvcj1y product1_zugxjl product3_owqrux).sample }
  main false
end

Fabricator(:image_money, from: :"attachment/image") do
  id "money_jcwnsz"
  main true
end
