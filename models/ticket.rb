require_relative("../db/sql_runner")
require_relative("../models/ticket")
require_relative("../models/film")


class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'] if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = 'INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id'
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM tickets'
    SqlRunner.run(sql)
  end


  def update()
    sql 'UPDATE customers SET (customer_id, film_id) = ($1, $2) WHEN id = $3'
    vales = [@customer_id, @film_id, @id]
  end



end
