require_relative("star")
require_relative("movie")
require_relative("../db/sql_runner")

class Casting
  attr_reader :id
  attr_accessor :movie_id, :star_id, :fee

    def initialize (options)
      @id = options['id'].to_i if options['id']
      @movie_id = options['movie_id'].to_i
      @star_id = options['star_id'].to_i
      @fee = options['fee']
    end

    def save
      sql = 'INSERT INTO castings
      (
        movie_id,
        star_id,
        fee
      )
      VALUES
      ( $1, $2, $3 )
      RETURNING id'
      values = [@movie_id, @star_id, @fee]
      casting = SqlRunner.run(sql, values).first
      @id = casting['id'].to_i
    end

    def update
      sql = 'UPDATE castings SET fee = $1 WHERE id = $2'
      values =[@fee, @id]
      SqlRunner.run(sql, values)
    end


    def self.all
      sql = 'SELECT * FROM castings'
      castings = SqlRunner.run(sql)
      result = castings.map {|casting| Casting.new(casting)}
      return result
    end


    def self.delete_all
      sql = 'DELETE FROM castings'
      movies = SqlRunner.run(sql)
    end
end
