# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Workshops are being created '

workshops = Workshop.create([
  {
    name: 'Full stack ruby on rails',
    description: 'Some dummy description for Workshop. Some dummy description for Workshop. Some dummy description for Workshop.
    Some dummy description for Workshop. Some dummy description for Workshop. Some dummy description for Workshop.
    Some dummy description for Workshop.',
    start_date: Date.today + 2.days,
    end_date: Date.today + 9.days,
    start_time: '10:00 AM',
    end_time: '3:00 PM',
    total_sits: 100,
    remainging_sits: 0,
    registration_fee: 1500
  },
  {
    name: 'Full stack python',
    description: 'Some dummy description for Workshop. Some dummy description for Workshop. Some dummy description for Workshop.
    Some dummy description for Workshop. Some dummy description for Workshop. Some dummy description for Workshop.
    Some dummy description for Workshop.',
    start_date: Date.today + 12.days,
    end_date: Date.today + 19.days,
    start_time: '10:00 AM',
    end_time: '3:00 PM',
    total_sits: 100,
    remainging_sits: 0,
    registration_fee: 1500
  },
  {
    name: 'Full stack node and react',
    description: 'Some dummy description for Workshop. Some dummy description for Workshop. Some dummy description for Workshop.
    Some dummy description for Workshop. Some dummy description for Workshop. Some dummy description for Workshop.
    Some dummy description for Workshop.',
    start_date: Date.today + 22.days,
    end_date: Date.today + 29.days,
    start_time: '10:00 AM',
    end_time: '3:00 PM',
    total_sits: 100,
    remainging_sits: 0,
    registration_fee: 1500
  }
])

puts 'Workshop created'
