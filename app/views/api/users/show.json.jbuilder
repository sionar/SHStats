# frozen_string_literal: true

json.users do
  @users.each do |user|
    json.partial! '/api/users/user', user:
  end
  json.user_agent @user_agent
end
