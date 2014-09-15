Fabricator(:item) do
  name { sequence(:name) { |i| "item#{i}" } }
end