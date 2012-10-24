Fabricator(:money) do
  offer
  money_owner { |atributos| atributos[:offer].receiver._id }
  quantity 10.3
end
