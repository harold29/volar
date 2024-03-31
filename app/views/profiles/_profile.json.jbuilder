json.extract! profile, :id, :first_name, :last_name, :phone_number_1, :phone_number_2, :gender, :created_at, :updated_at
json.url profile_url(profile, format: :json)
