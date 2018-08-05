require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

Screening.delete_all()
Film.delete_all()
Customer.delete_all()
Ticket.delete_all()

require('pry-byebug')

customer1 = Customer.new({'name' => 'Connie', 'funds' => 50})
customer2 = Customer.new({'name' => 'Kate', 'funds' => 40})
customer3 = Customer.new({'name' => 'James', 'funds' => 80})

customer1.save()
customer2.save()

film1 = Film.new({'title' => 'Mission Impossible', 'price' => 10})
film2 = Film.new({'title' => 'incredibles 2', 'price' => 8})

film1.save()
film2.save()


ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})

ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})

ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})

ticket4 =
Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()


screening_time1 = Screening.new('screening_date' => '06/08/2018', 'screening_time' => '13:00', 'ticket_id' => ticket1.id)

screening_time1.save()

binding.pry
nil
