# frozen_string_literal: true

module Api
  class GamesController < ApplicationController
    def create
      unless request.headers['User-Agent'].include? 'UnityPlayer'
        render json: { errors: ['There was an issue submitting the game.'] },
               status: 400 and return
      end

      submitter = User.find_by(steam_id: params[:submitter_id])
      submitter ||= User.create!(steam_id: params[:submitter_id], steam_name: params[:submitter_name])
      @game = Game.create!(game_type: params[:game_type], num_players: params[:num_players],
                           winning_team: params[:winning_team], win_type: params[:win_type], submitter_id: submitter.id, submitter_ip: request.remote_ip)
      ints = param_ints
      ints.each do |i|
        user = create_or_update_user(i)
        role = params[int_to_sym(i, 'role')]
        win = role == params[:winning_team] || (role == 'hitler' && params[:winning_team] == 'fascist')
        player = Player.create!(user:, game: @game, role:, win:)
      end
      render :create, status: 200
    end

    def index
      games = Game.where(game_params)
      @stats = []
      @stats.push(game_stats(games, :any))
      (5..10).each do |i|
        games = Game.where(game_params).where(num_players: i)
        @stats.push(game_stats(games, i))
      end
      render :index, status: 200
    end

    def update
      unless request.headers['User-Agent'].include? 'UnityPlayer'
        render json: { errors: ['There was an issue updating the game.'] },
               status: 400 and return
      end

      @game = Game.find(params[:id])
      render json: { errors: ['Game not found.'] }, status: 404 and return unless @game

      isMissingParams? or isParamsUnmatched? and render json: { errors: ['There was an issue updating the game.'] },
                                                        status: 422 and return
      @game.update!(game_type: params[:game_type], winning_team: params[:winning_team], win_type: params[:win_type])
      render :update, status: 200
    end

    def game_params
      p = {}
      p[:game_type] = params[:game_type] if params[:game_type] && params[:game_type] != 'any'
      p
    end

    def game_stats(games, num_players)
      {
        num_players:,
        total_games: games.count,
        liberal_wins: games.where(winning_team: 'liberal').count,
        liberal_wins_policy: games.where(winning_team: 'liberal', win_type: 'policy').count,
        fascist_wins_policy: games.where(winning_team: 'fascist', win_type: 'policy').count
      }
    end

    def isMissingParams?
      return true if !params[:game_type] || !params[:winning_team] || !params[:win_type]

      false
    end

    def isParamsUnmatched?
      submitter = User.find_by(steam_id: params[:submitter_id])
      submitter ||= User.create!(steam_id: params[:submitter_id], steam_name: params[:submitter_name])

      return true if (@game.submitter_id != submitter.id || (@game.submitter_ip != request.remote_ip)

      false
    end
  end
end
