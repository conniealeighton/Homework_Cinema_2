require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'] if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = 'INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id'
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

  def update()
    sql = 'UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3'
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def show_films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map { |film| Film.new(film)}
  end

  def decrease_funds(film)
    sql = 'UPDATE customers SET funds = $1'
    values = [@funds = @funds - film.price]
    SqlRunner.run(sql, values)
  end

  def tickets_bought()
  show_films.length
  end

  

end
