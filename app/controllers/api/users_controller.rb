# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    def index
      case params[:sort_by]
      when 'total_wr'
        @users = User.sorted_by_total_wr(game_params)
      when 'liberal_wr'
        @users = User.sorted_by_lib_wr(game_params)
      when 'fascist_wr'
        @users = User.sorted_by_fas_wr(game_params)
      end
      @users = @users.map do |user|
        get_stats(user)
      end
      @users = @users.select{|user| user[:total_games] > 0}

      render :index, status: 200
    end

    def show
      @users = []
      ints = param_ints
      ints.each do |i|
        user = params[:lookup] == 'true' ? User.find_by(steam_id: params[:steam_id0]) : create_or_update_user(i)
        @users.push(get_stats(user))
      end
      @user_agent = request.headers["User-Agent"]
      render :show, status: 200
    end

    def search
      steam_id = params[:steam_id]
      steam_name = params[:steam_name]
      unless steam_id || steam_name
        render json: { errors: ['no steam_id or steam_name entered'] }, status: 400 and return
      end

      options = {
        fields: [:steam_name],
        match: :word_middle,
        limit: 1,
        misspellings: { below: 3 }
      }

      user = (params[:steam_id] && User.find_by(steam_id:))
      unless user
        results = params[:steam_name] && User.search(params[:steam_name], **options)
        user = results.first if results
      end
      render json: { errors: ['no user found'] }, status: 404 and return unless user

      @user = get_stats(user)
      render :search, status: 200
    end

    def gamble
      user = User.find_by(steam_id: params[:steam_id])
      render json: { errors: ['no user found'] }, status: 404 and return unless user

      gamble_successes = user.gamble_successes
      gamble_attempts = user.gamble_attempts
      gamble_successes += 1 if params[:gamble_result] == 'win'
      user.update!(gamble_successes:, gamble_attempts: gamble_attempts + 1)
      render :gamble, status: 200
    end

    def game_params
      p = {}
      p[:'game.num_players'] = params[:num_players] if params[:num_players] && params[:num_players] != '0'
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
