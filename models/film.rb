require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'] if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = 'INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id'
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM films'
    SqlRunner.run(sql)
  end

  def update()
    sql = 'UPDATE films SET (title, price) = ($1, $2) WHERE id = $3'
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def show_customers()
    sql = 'SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1'
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map { |customer| Customer.new(customer)}
  end

  def film_attendees
    show_customers.length
  end

  def self.check_most_popular()
    sql = 'SELECT title FROM films GROUP BY title ORDER BY COUNT title DESC'
    SqlRunner.run(sql)
  end

end
