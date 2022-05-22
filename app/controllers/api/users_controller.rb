# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    def show
      @users = []
      ints = param_ints
      ints.each do |i|
        steam_id = params[int_to_sym(i, 'steam_id')]
        steam_name = params[int_to_sym(i, 'steam_name')]
        user = User.find_by(steam_id:)
        if user
          user.update!(steam_name:)
        else
          user = User.create!(steam_id:, steam_name:)
        end
        @users.push(get_stats(user))
      end

      render :show, status: 200
    end

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

    def game_params
      p = {}
      p[:'game.num_players'] = params[:num_players] if params[:num_players] && params[:num_players] != 0
      p[:'game.game_type'] = params[:game_type] if params[:game_type] && params[:game_type] != 'any'
      p
    end

    def get_stats(user)
      user_obj = {}
      players = Player.joins(:user, :game).where(user:).where(game_params)
      user_obj[:steam_id] = user.steam_id
      user_obj[:steam_name] = user.steam_name
      user_obj[:total_games] = players.count
      user_obj[:total_wins] = players.where(win: true).count
      user_obj[:liberal_games] = players.where(role: 'liberal').count
      user_obj[:liberal_wins] = players.where(role: 'liberal', win: true).count
      user_obj[:fascist_games] = players.where(role: 'fascist').count
      user_obj[:fascist_wins] = players.where(role: 'fascist', win: true).count
      user_obj[:hitler_games] = players.where(role: 'hitler').count
      user_obj[:hitler_wins] = players.where(role: 'hitler', win: true).count
      user_obj[:gamble_attempts] = user.gamble_attempts
      user_obj[:gamble_successes] = user.gamble_successes
      user_obj
    end
  end
end
