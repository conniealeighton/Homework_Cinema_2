require_relative("../db/sql_runner")
require_relative("../models/screening")

class Film

  attr_reader :id
  attr_accessor :title, :price, :film_id

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

  def check_most_popular()
   sql = "SELECT screenings.screening_time, COUNT (screenings.screening_time) FROM screenings INNER JOIN tickets ON screenings.id = screenings.ticket_id GROUP BY screenings.screening_time ORDER BY (screenings.screening_time) DESC LIMIT 1 WHERE screenings.film_id = $1"
   values = [@id]
   tickets = SqlRunner.run(sql, values)
   tickets.map { |ticket| Ticket.new(ticket)}

  end

  #
  # SELECT       `column`,
  #            COUNT(`column`) AS `value_occurrence`
  #   FROM     `my_table`
  #   GROUP BY `column`
  #   ORDER BY `value_occurrence` DESC
  #   LIMIT    1;

end
