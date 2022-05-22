# frozen_string_literal: true

json.users do
  json.array!(@users) do |user|
    json.partial! '/api/users/user', user: user
  end
end
