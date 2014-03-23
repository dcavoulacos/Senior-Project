# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140321203416) do

  create_table "action_frames", force: true do |t|
    t.string   "name"
    t.boolean  "ends_set"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actions", force: true do |t|
    t.integer  "action_frame_id"
    t.integer  "player_id"
    t.string   "action_type"
    t.decimal  "end_position_x"
    t.decimal  "end_position_y"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "teammate"
  end

  add_index "actions", ["action_frame_id"], name: "index_actions_on_action_frame_id"
  add_index "actions", ["player_id"], name: "index_actions_on_player_id"

  create_table "players", force: true do |t|
    t.integer  "action_frame_id"
    t.string   "role"
    t.decimal  "position_x"
    t.decimal  "position_y"
    t.boolean  "has_ball"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["action_frame_id"], name: "index_players_on_action_frame_id"

end
