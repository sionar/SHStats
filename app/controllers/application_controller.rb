# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def param_ints
    ints = []
    10.times do |i|
      ints.push(i) if params[int_to_sym(i, 'steam_id')] && params[int_to_sym(i, 'steam_name')]
    end
    ints
  end

  def int_to_sym(int, base)
    (base + int.to_s).to_sym
  end

  def create_or_update_user(i)
    steam_id = params[int_to_sym(i, 'steam_id')]
    steam_name = params[int_to_sym(i, 'steam_name')]
    user = User.find_by(steam_id:)
    if user
      user.update!(steam_name:)
    else
      user = User.create!(steam_id:, steam_name:)
    end
    user
  end
end
