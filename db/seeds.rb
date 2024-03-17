# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create Countries
Country.create!(name: 'United States', code: 'US', phone_code: '+1', language: 'English', continent: 'North America', time_zone: 'UTC-4 to UTC-10')
Country.create!(name: 'European Union', code: 'EU', phone_code: '+32', language: 'English, French, German', continent: 'Europe',
                time_zone: 'UTC-1 to UTC+3')
Country.create!(name: 'United Kingdom', code: 'GB', phone_code: '+44', language: 'English', continent: 'Europe', time_zone: 'UTC')
Country.create!(name: 'Japan', code: 'JP', phone_code: '+81', language: 'Japanese', continent: 'Asia', time_zone: 'UTC+9')
Country.create!(name: 'Australia', code: 'AU', phone_code: '+61', language: 'English', continent: 'Oceania', time_zone: 'UTC+8 to UTC+10')
Country.create!(name: 'Canada', code: 'CA', phone_code: '+1', language: 'English, French', continent: 'North America', time_zone: 'UTC-3.5 to UTC-8')
Country.create!(name: 'Switzerland', code: 'CH', phone_code: '+41', language: 'German, French, Italian, Romansh', continent: 'Europe',
                time_zone: 'UTC+1')
Country.create!(name: 'China', code: 'CN', phone_code: '+86', language: 'Mandarin', continent: 'Asia', time_zone: 'UTC+8')
Country.create!(name: 'Brazil', code: 'BR', phone_code: '+55', language: 'Portuguese', continent: 'South America', time_zone: 'UTC-2 to UTC-5')
Country.create!(name: 'Argentina', code: 'AR', phone_code: '+54', language: 'Spanish', continent: 'South America', time_zone: 'UTC-3')
Country.create!(name: 'Turkey', code: 'TR', phone_code: '+90', language: 'Turkish', continent: 'Asia', time_zone: 'UTC+3')

# Create currencies
Currency.create!(name: 'US Dollar', code: 'USD', symbol: '$', country: Country.find_by(name: 'United States'))
Currency.create!(name: 'Euro', code: 'EUR', symbol: '€', country: Country.find_by(name: 'European Union'))
Currency.create!(name: 'Pound Sterling', code: 'GBP', symbol: '£', country: Country.find_by(name: 'United Kingdom'))
Currency.create!(name: 'Japanese Yen', code: 'JPY', symbol: '¥', country: Country.find_by(name: 'Japan'))
Currency.create!(name: 'Australian Dollar', code: 'AUD', symbol: '$', country: Country.find_by(name: 'Australia'))
Currency.create!(name: 'Canadian Dollar', code: 'CAD', symbol: '$', country: Country.find_by(name: 'Canada'))
Currency.create!(name: 'Swiss Franc', code: 'CHF', symbol: 'CHF', country: Country.find_by(name: 'Switzerland'))
Currency.create!(name: 'Chinese Yuan', code: 'CNY', symbol: '¥', country: Country.find_by(name: 'China'))

# Create airports
Airport.create!(
  name: 'John F. Kennedy International Airport',
  city: 'New York',
  iata_code: 'JFK',
  icao_code: 'KJFK',
  time_zone: 'America/New_York',
  country: Country.find_by(name: 'United States')
)
Airport.create!(
  name: 'Los Angeles International Airport',
  city: 'Los Angeles',
  iata_code: 'LAX',
  icao_code: 'KLAX',
  time_zone: 'America/Los_Angeles',
  country: Country.find_by(name: 'United States')
)
Airport.create!(
  name: 'Chicago O\'Hare International Airport',
  city: 'Chicago',
  iata_code: 'ORD',
  icao_code: 'KORD',
  time_zone: 'America/Chicago',
  country: Country.find_by(name: 'United States')
)
Airport.create!(
  name: 'Miami International Airport',
  city: 'Miami',
  iata_code: 'MIA',
  icao_code: 'KMIA',
  time_zone: 'America/New_York',
  country: Country.find_by(name: 'United States')
)
Airport.create!(
  name: 'San Francisco International Airport',
  city: 'San Francisco',
  iata_code: 'SFO',
  icao_code: 'KSFO',
  time_zone: 'America/Los_Angeles',
  country: Country.find_by(name: 'United States')
)
Airport.create!(
  name: 'Seattle-Tacoma International Airport',
  city: 'Seattle',
  iata_code: 'SEA',
  icao_code: 'KSEA',
  time_zone: 'America/Los_Angeles',
  country: Country.find_by(name: 'United States')
)
Airport.create!(
  name: 'Dallas/Fort Worth International Airport',
  city: 'Dallas',
  iata_code: 'DFW',
  icao_code: 'KDFW',
  time_zone: 'America/Chicago',
  country: Country.find_by(name: 'United States')
)
Airport.create!(
  name: 'Denver International Airport',
  city: 'Denver',
  iata_code: 'DEN',
  icao_code: 'KDEN',
  time_zone: 'America/Denver',
  country: Country.find_by(name: 'United States')
)
Airport.create!(
  name: 'Orlando International Airport',
  city: 'Orlando',
  iata_code: 'MCO',
  icao_code: 'KMCO',
  time_zone: 'America/New_York',
  country: Country.find_by(name: 'United States')
)
Airport.create!(
  name: 'Hartsfield-Jackson Atlanta International Airport',
  city: 'Atlanta',
  iata_code: 'ATL',
  icao_code: 'KATL',
  time_zone: 'America/New_York',
  country: Country.find_by(name: 'United States')
)
Airport.create!(
  name: 'Toronto Pearson International Airport',
  city: 'Toronto',
  iata_code: 'YYZ',
  icao_code: 'CYYZ',
  time_zone: 'America/Toronto',
  country: Country.find_by(name: 'Canada')
)
Airport.create!(
  name: 'Vancouver International Airport',
  city: 'Vancouver',
  iata_code: 'YVR',
  icao_code: 'CYVR',
  time_zone: 'America/Vancouver',
  country: Country.find_by(name: 'Canada')
)
Airport.create!(
  name: 'Montreal-Pierre Elliott Trudeau International Airport',
  city: 'Montreal',
  iata_code: 'YUL',
  icao_code: 'CYUL',
  time_zone: 'America/Toronto',
  country: Country.find_by(name: 'Canada')
)
Airport.create!(
  name: 'Calgary International Airport',
  city: 'Calgary',
  iata_code: 'YYC',
  icao_code: 'CYYC',
  time_zone: 'America/Edmonton',
  country: Country.find_by(name: 'Canada')
)
Airport.create!(
  name: 'Ottawa Macdonald-Cartier International Airport',
  city: 'Ottawa',
  iata_code: 'YOW',
  icao_code: 'CYOW',
  time_zone: 'America/Toronto',
  country: Country.find_by(name: 'Canada')
)
Airport.create!(
  name: 'Halifax Stanfield International Airport',
  city: 'Halifax',
  iata_code: 'YHZ',
  icao_code: 'CYHZ',
  time_zone: 'America/Halifax',
  country: Country.find_by(name: 'Canada')
)
Airport.create!(
  name: 'Québec City Jean Lesage International Airport',
  city: 'Québec City',
  iata_code: 'YQB',
  icao_code: 'CYQB',
  time_zone: 'America/Toronto',
  country: Country.find_by(name: 'Canada')
)
Airport.create!(
  name: 'Ministro Pistarini International Airport',
  city: 'Buenos Aires',
  iata_code: 'EZE',
  icao_code: 'SAEZ',
  time_zone: 'America/Argentina/Buenos_Aires',
  country: Country.find_by(name: 'Argentina')
)
Airport.create!(
  name: 'Istanbul Airport',
  city: 'Istanbul',
  iata_code: 'IST',
  icao_code: 'LTBA',
  time_zone: 'Europe/Istanbul',
  country: Country.find_by(name: 'Turkey')
)
Airport.create!(
  name: 'São Paulo-Guarulhos International Airport',
  city: 'São Paulo',
  iata_code: 'GRU',
  icao_code: 'SBGR',
  time_zone: 'America/Sao_Paulo',
  country: Country.find_by(name: 'Brazil')
)

# Create airlines
Carrier.create!(name: 'American Airlines', code: 'AA', logo: Faker::Internet.url)
Carrier.create!(name: 'Delta Air Lines', code: 'DL', logo: Faker::Internet.url)
Carrier.create!(name: 'United Airlines', code: 'UA', logo: Faker::Internet.url)
Carrier.create!(name: 'Southwest Airlines', code: 'WN', logo: Faker::Internet.url)
Carrier.create!(name: 'JetBlue Airways', code: 'B6', logo: Faker::Internet.url)
Carrier.create!(name: 'Alaska Airlines', code: 'AS', logo: Faker::Internet.url)
Carrier.create!(name: 'Spirit Airlines', code: 'NK', logo: Faker::Internet.url)
Carrier.create!(name: 'Frontier Airlines', code: 'F9', logo: Faker::Internet.url)
Carrier.create!(name: 'Hawaiian Airlines', code: 'HA', logo: Faker::Internet.url)
Carrier.create!(name: 'Turkish Airlines', code: 'TK', logo: Faker::Internet.url)

# Payment Plans
PaymentPlan.create!(name: 'Standard', payment_type: 'Credit Card', description: 'Standard payment plan', payment_terms: 'D=1',
                    payment_terms_description: 'Payment due in full within 1 day of invoice date')
PaymentPlan.create!(name: 'Weekly', payment_type: 'Credit Card', description: 'Net 15 payment plan', payment_terms: 'D>7;D<70',
                    payment_terms_description: 'Payment divided into weekly installments')
PaymentPlan.create!(name: 'Bi-Weekly', payment_type: 'Credit Card', description: 'Net 30 payment plan', payment_terms: 'D>15;D<70',
                    payment_terms_description: 'Payment divided into bi-weekly installments')
PaymentPlan.create!(name: 'Monthly', payment_type: 'Credit Card', description: 'Net 30 payment plan', payment_terms: 'D>30;D<180',
                    payment_terms_description: 'Payment divided into monthly installments')
PaymentPlan.create!(name: 'Daily', payment_type: 'Credit Card', description: 'Daily payment plan', payment_terms: 'D=15;D<100',
                    payment_terms_description: 'Payment due in full within 1 day of invoice date')
