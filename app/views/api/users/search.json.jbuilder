# frozen_string_literal: true

json.users do
  json.partial! '/api/users/user', user: @user
end
