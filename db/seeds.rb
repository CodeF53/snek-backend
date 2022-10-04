puts '🌱 Seeding spices...'

10.times do
  user = User.create(username: Faker::Internet.unique.username, password: Faker::Internet.password)
  user.initialize_session_cookie

  rand(100).times do
    user.new_play(playtime: rand(600), score: rand(50))
  end
end

puts '✅ Done seeding!'
