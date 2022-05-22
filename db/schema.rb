# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_220_522_000_110) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'games', force: :cascade do |t|
    t.string 'game_type', null: false
    t.integer 'num_players', null: false
    t.string 'winning_team', null: false
    t.string 'win_type', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'players', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'role', null: false
    t.bigint 'game_id'
    t.bigint 'user_id'
    t.boolean 'win'
    t.index ['game_id'], name: 'index_players_on_game_id'
    t.index ['user_id'], name: 'index_players_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'steam_id', null: false
    t.string 'steam_name', null: false
    t.integer 'gamble_successes', default: 0
    t.integer 'gamble_attempts', default: 0
    t.index ['steam_id'], name: 'index_users_on_steam_id', unique: true
    t.index ['steam_name'], name: 'index_users_on_steam_name'
  end
end
