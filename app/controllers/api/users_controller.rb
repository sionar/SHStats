# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    def index
      case params[:sort_by]
      when 'total_wr'
        @users = User.sorted_by_total_wr(game_params)
      when 'liberal_wr'
        @users = User.all.sort_by(&:liberal_wr)
      when 'fascist_wr'
        @users = User.all.sort_by(&:fascist_wr)
      end

      @users = @users.map do |user|
        get_stats(user)
      end

      render :index, status: 200
    end

    def show
      @users = []
      ints = param_ints
      ints.each do |i|
        user = create_or_update_user(i)
        @users.push(get_stats(user))
      end
      render :show, status: 200
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

    def liberal_wr
      players = players.join(:game).where(game_params).where(role: 'liberal')
      return 0 if players.count = 0

      (players.where(win: true).count / players.count)
    end

    def fascist_wr
      players = players.join(:game).where(game_params).where(role: 'fascist')
      return 0 if players.count = 0

      (players.where(win: true).count / players.count)
    end
  end
end
