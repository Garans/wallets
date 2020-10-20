# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  { id: 'USD', symbol_icon: '$', is_base: true },
  { id: 'EUR', symbol_icon: '€', is_base: false },
  { id: 'UAH', symbol_icon: '₴', is_base: false }
].each do |currency|
  record = Currency.find_or_initialize_by(id: currency[:id])
  record.assign_attributes(currency)
  record.save!
end

SystemSetting.find_or_create_by!(
  country: 'Ukraine',
  country_short_code: 'UA',
  check_iban_number: 12,
  name: 'The base bank of world',
  mfo: 308_585
)

[
  { first_currency_id: 'UAH', second_currency_id: 'USD', course: 0.0351559 },
  { first_currency_id: 'UAH', second_currency_id: 'EUR', course: 0.0300054 },
  { first_currency_id: 'USD', second_currency_id: 'EUR', course: 0.853495 },
  { first_currency_id: 'USD', second_currency_id: 'UAH', course: 28.4448 },
  { first_currency_id: 'EUR', second_currency_id: 'USD', course: 1.17165 },
  { first_currency_id: 'EUR', second_currency_id: 'UAH', course: 33.3274 }
].each do |record|
  cc = CurrencyConverter.find_or_initialize_by(first_currency_id: record[:first_currency_id],
                                               second_currency_id: record[:second_currency_id])
  cc.course = record[:course]
  cc.save!
end

[
  { id: 1, commission_type: 0, rate: 3, from_price: 0.01, to_price: 100 },
  { id: 2, commission_type: 1, rate: 0.02, from_price: 100.01, to_price: 2000 },
  { id: 3, commission_type: 1, rate: 0.01, from_price: 2000.01 }
].each do |record|
  data = CommissionRule.find_or_initialize_by(id: record[:id])
  data.assign_attributes(**record)
  data.save!
end

scores = []

Currency.all.each do |currency|
  atm = Atm.find_or_initialize_by(currency: currency)
  next unless atm.new_record?

  data = ScoreGenerator.new(currency)
  score = data.call
  score = data.call while scores.include?(score)
  scores << score
  iban = IbanNumberGenerator.perform(SystemSetting.first, score, currency)
  atm.assign_attributes(number: iban, address: 'first')
  atm.save!
end
