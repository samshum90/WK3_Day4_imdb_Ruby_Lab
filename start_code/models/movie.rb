require_relative("casting")
require_relative("star")
require_relative("../db/sql_runner")

class Movie

attr_reader :id
attr_accessor :title, :genre, :budget

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @buget = options['budget']
  end

  def save
    sql = 'INSERT INTO movies
    (
      title,
      genre,
      budget
    )
    VALUES
    ( $1, $2, $3 )
    RETURNING id'
    values = [@title, @genre, @budget]
    movie = SqlRunner.run(sql, values).first
    @id = movie['id'].to_i
  end

  def update
    sql = 'UPDATE movies SET (title, genre, budget) = ( $1, $2, $3 ) WHERE id = $4'
    values =[@title, @genre, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def stars
    sql = 'SELECT stars.* FROM stars
          INNER JOIN castings
          ON castings.star_id = stars.id
          WHERE movie_id = $1'
    values = [@id]
    stars = SqlRunner.run(sql, values)
    results = stars.map {|star| Star.new(star)}
    return results
  end

  def cast_cost
    sql = 'SELECT castings.fee FROM castings
        INNER JOIN movies
        ON castings.movie_id = movie_id
        WHERE movie_id = $1'
    values = [@id]
    cost = SqlRunner.run(sql, values)
    # results = cost.map { |cost| cost.reduce(0) {|cost, total| cost += total}}
    return cost
  end

  # def update_budget()
  #   sql = 'UPDATE movies SET budget = $1 WHERE id = $2'
  #   values = [@budget, @id]
  #   SqlRunner.run(sql, values)
  # end

  def self.all
    sql = 'SELECT * FROM movies'
    movies = SqlRunner.run(sql)
    result = movies.map {|movie| Movie.new(movie)}
    return result
  end

  def self.delete_all
    sql = 'DELETE FROM movies'
    movies = SqlRunner.run(sql)
  end

end
