class Api::GamesController < ApplicationController
  def create
    game = Game.create!(game_type: params[:game_type], num_players: params[:num_players], winning_team: params[:winning_team], win_type: params[:win_type])
    ints = param_ints
    ints.each do |i|
      user = create_or_update_user(i)
      role = params[int_to_sym(i, 'role')]
      win = role == params[:winning_team] || ( role == 'hitler' && params[:winning_team] == 'fascist' ) 
      player = Player.create!(user: user, game: game, role: role, win: win)
    end
    render head :ok, content_type: 'text/html'
  end
end
