require_relative('models/casting')
require_relative('models/movie')
require_relative('models/star')

require('pry-byebug')

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

movie1 = Movie.new( {'title' => 'Jojo Rabbit', 'genre' => 'comedy', 'budget' => 1000000000})

movie1.save

movie1.genre = 'drama'
movie1.update

star1 = Star.new( {'first_name' => 'Roman', 'last_name' =>'Griffin Davis' })
star2 = Star.new( {'first_name' => 'Thomasin', 'last_name' =>'Mckenzie' })
star3 = Star.new( {'first_name' => 'Scarlett', 'last_name' =>'Johansson' })
star1.save
star2.save
star3.save

star1.last_name = 'Griffin-Davis'
star1.update

casting1 = Casting.new ({ 'movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => 5000000})
casting2 = Casting.new ({ 'movie_id' => movie1.id, 'star_id' => star2.id, 'fee' => 2000000})
casting3 = Casting.new ({ 'movie_id' => movie1.id, 'star_id' => star3.id, 'fee' => 10000000})
casting1.save
casting2.save
casting3.save

casting1.fee = 6000000
casting1.update

# movie1.update_budget = (casting1.fee + casting2.fee + casting3.fee)


binding.pry
nil
