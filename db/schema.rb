# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_05_015244) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "additional_services", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "flight_offer_id", null: false
    t.string "service_type"
    t.string "service_description"
    t.decimal "service_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_offer_id"], name: "index_additional_services_on_flight_offer_id"
  end

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "profile_id", null: false
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.uuid "country_id", null: false
    t.integer "address_type", default: 0
    t.boolean "address_verified"
    t.boolean "billing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_addresses_on_country_id"
    t.index ["profile_id"], name: "index_addresses_on_profile_id"
  end

  create_table "airports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "iata_code"
    t.string "icao_code"
    t.string "time_zone"
    t.uuid "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_airports_on_country_id"
  end

  create_table "carriers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "phone_code"
    t.string "language"
    t.string "continent"
    t.string "time_zone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.string "code"
    t.uuid "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_currencies_on_country_id"
  end

  create_table "documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "document_type", default: 0, null: false
    t.string "document_number"
    t.date "expiration_date"
    t.uuid "issuance_country_id", null: false
    t.uuid "nationality_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issuance_country_id"], name: "index_documents_on_issuance_country_id"
    t.index ["nationality_id"], name: "index_documents_on_nationality_id"
  end

  create_table "fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "flight_offer_id", null: false
    t.string "fee_type"
    t.string "fee_description"
    t.decimal "fee_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_offer_id"], name: "index_fees_on_flight_offer_id"
  end

  create_table "flight_offers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "internal_id"
    t.string "source"
    t.boolean "instant_ticketing_required"
    t.boolean "non_homogeneous"
    t.boolean "one_way"
    t.date "last_ticketing_date"
    t.integer "number_of_bookable_seats"
    t.decimal "price_total"
    t.boolean "payment_card_required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "currency_id", null: false
    t.index ["currency_id"], name: "index_flight_offers_on_currency_id"
  end

  create_table "itineraries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "flight_offer_id", null: false
    t.string "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_offer_id"], name: "index_itineraries_on_flight_offer_id"
  end

  create_table "payment_plans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "payment_type"
    t.string "description"
    t.string "payment_terms"
    t.string "payment_terms_description"
    t.string "payment_terms_conditions"
    t.string "payment_terms_conditions_url"
    t.string "payment_terms_conditions_file"
    t.string "payment_terms_conditions_file_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "flight_offer_id", null: false
    t.decimal "price_total"
    t.decimal "price_grand_total"
    t.uuid "price_currency_id"
    t.uuid "billing_currency_id"
    t.decimal "base_fare"
    t.decimal "refundable_taxes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["billing_currency_id"], name: "index_prices_on_billing_currency_id"
    t.index ["flight_offer_id"], name: "index_prices_on_flight_offer_id"
    t.index ["price_currency_id"], name: "index_prices_on_price_currency_id"
  end

  create_table "profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number_1"
    t.string "phone_number_2"
    t.string "gender"
    t.boolean "available"
    t.boolean "deleted"
    t.datetime "birthdate"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "segments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "itinerary_id", null: false
    t.uuid "departure_airport_id"
    t.uuid "arrival_airport_id"
    t.datetime "departure_at"
    t.datetime "arrival_at"
    t.uuid "carrier_id", null: false
    t.string "flight_number"
    t.string "aircraft_code"
    t.string "duration"
    t.integer "stops_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arrival_airport_id"], name: "index_segments_on_arrival_airport_id"
    t.index ["carrier_id"], name: "index_segments_on_carrier_id"
    t.index ["departure_airport_id"], name: "index_segments_on_departure_airport_id"
    t.index ["itinerary_id"], name: "index_segments_on_itinerary_id"
  end

  create_table "stops", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "segment_id", null: false
    t.uuid "airport_id", null: false
    t.string "duration"
    t.datetime "arrival_at"
    t.datetime "departure_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["airport_id"], name: "index_stops_on_airport_id"
    t.index ["segment_id"], name: "index_stops_on_segment_id"
  end

  create_table "taxes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "flight_offer_id", null: false
    t.string "tax_code"
    t.string "tax_description"
    t.decimal "tax_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_offer_id"], name: "index_taxes_on_flight_offer_id"
  end

  create_table "telephones", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "area_code"
    t.string "phone_number"
    t.integer "phone_type"
    t.boolean "phone_verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_telephones_on_user_id"
  end

  create_table "travelers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.integer "traveler_type", default: 0
    t.date "birthdate"
    t.uuid "document_id", null: false
    t.uuid "telephone_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_travelers_on_document_id"
    t.index ["telephone_id"], name: "index_travelers_on_telephone_id"
    t.index ["user_id"], name: "index_travelers_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "role"
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.boolean "ban", default: false
    t.datetime "banned_at"
    t.string "reason_for_ban"
    t.integer "strikes", default: 0, null: false
    t.boolean "flagged_for_activity", default: false
    t.boolean "deleted"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "additional_services", "flight_offers"
  add_foreign_key "addresses", "countries"
  add_foreign_key "addresses", "profiles"
  add_foreign_key "airports", "countries"
  add_foreign_key "currencies", "countries"
  add_foreign_key "documents", "countries", column: "issuance_country_id"
  add_foreign_key "documents", "countries", column: "nationality_id"
  add_foreign_key "fees", "flight_offers"
  add_foreign_key "flight_offers", "currencies"
  add_foreign_key "itineraries", "flight_offers"
  add_foreign_key "prices", "currencies", column: "billing_currency_id"
  add_foreign_key "prices", "currencies", column: "price_currency_id"
  add_foreign_key "prices", "flight_offers"
  add_foreign_key "profiles", "users"
  add_foreign_key "segments", "airports", column: "arrival_airport_id"
  add_foreign_key "segments", "airports", column: "departure_airport_id"
  add_foreign_key "segments", "carriers"
  add_foreign_key "segments", "itineraries"
  add_foreign_key "stops", "airports"
  add_foreign_key "stops", "segments"
  add_foreign_key "taxes", "flight_offers"
  add_foreign_key "telephones", "users"
  add_foreign_key "travelers", "documents"
  add_foreign_key "travelers", "telephones"
  add_foreign_key "travelers", "users"
end
