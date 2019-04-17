
john = User.create(username: "john95", password:11)
andy = User.create(username: "andy258", password:24)
steph = User.create(username: "steph121",password:29)

#populate game database with game records

hangman = FormulateHangman.new

hangman.get_countries.each do |country|
   game = Game.create(name: "hangman_with_countries",genre: "countries", word: country)
end

hangman.get_desserts.each do |dessert|
  game = Game.create(name: "hangman_with_desserts",genre: "British desserts", word: dessert)
end

hangman.get_minerals.each do |rock_mineral|
  game = Game.create(name: "hangman_with_rocks_minerals",genre: "rocks and minerals ", word: rock_mineral)
end


gameplay1 = GamePlay.create(result: true, user_id: john.id, game_id: Game.all.sample.id)
gameplay2 = GamePlay.create(result: true, user_id: steph.id, game_id: Game.all.sample.id)
gameplay3 = GamePlay.create(result: false, user_id: john.id, game_id: Game.all.sample.id)
