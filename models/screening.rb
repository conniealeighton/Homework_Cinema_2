require_relative("../db/sql_runner")
require_relative("../models/ticket")

class Screening

  attr_reader :id, :ticket_id, :screening_date, :screening_time

  def initialize(options)
    @id = options['id'] if options['id']
    @screening_date = options['screening_date']
    @screening_time = options['screening_time']
    @ticket_id = options['ticket_id']
  end

  def save()
    sql = 'INSERT INTO screenings (screening_date, screening_time, ticket_id) VALUES ($1, $2, $3) RETURNING id'
    values = [@screening_date, @screening_time, @ticket_id]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM screenings'
    SqlRunner.run(sql)
  end


end
