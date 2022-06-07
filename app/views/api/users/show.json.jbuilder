# frozen_string_literal: true

json.users do
  @users.each do |user|
    json.partial! '/api/users/user', user:
  end
end
