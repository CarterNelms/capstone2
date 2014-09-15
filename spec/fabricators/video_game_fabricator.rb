Fabricator(:video_game) do
  name { sequence(:name) { |i| "video_game#{i}" } }
end