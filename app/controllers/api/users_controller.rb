class Api::UsersController < ApplicationController
  def show
    @users = []
    ints = get_param_ints
    ints.each do |i|
      steam_id = params[int_to_sym(i, 'steam_id')]
      steam_name = params[int_to_sym(i, 'steam_name')]

      user = User.find_by(steam_id: steam_id)
      if user
        user.update!(steam_name: steam_name)
        @users.push(user)
      else
        user = User.create!(steam_id: steam_id, steam_name: steam_name)
        @users.push(user)
      end
    end

    render :show, status: 200
  end

  def get_param_ints
    ints = []
    10.times do |i|
      if params[int_to_sym(i, 'steam_id')] && params[int_to_sym(i, 'steam_name')]
        ints.push(i)
      end
    end
    ints
  end

  def int_to_sym(int, base)
    return (base + int.to_s).to_sym
  end
end
