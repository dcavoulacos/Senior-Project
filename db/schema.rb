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

ActiveRecord::Schema.define(version: 20140415021711) do

  create_table "action_frames", force: true do |t|
    t.integer  "set_play_id"
    t.integer  "prev_id"
    t.integer  "next_id"
    t.string   "name"
    t.boolean  "ends_set"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "action_frames", ["set_play_id"], name: "index_action_frames_on_set_play_id"

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

  create_table "offenses", force: true do |t|
    t.text     "name"
    t.decimal  "pg_x"
    t.decimal  "pg_y"
    t.boolean  "pg_ball"
    t.decimal  "sg_x"
    t.decimal  "sg_y"
    t.boolean  "sg_ball"
    t.decimal  "sf_x"
    t.decimal  "sf_y"
    t.boolean  "sf_ball"
    t.decimal  "pf_x"
    t.decimal  "pf_y"
    t.boolean  "pf_ball"
    t.decimal  "c_x"
    t.decimal  "c_y"
    t.boolean  "c_ball"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.integer  "set_play_id"
    t.string   "role"
    t.decimal  "position_x"
    t.decimal  "position_y"
    t.boolean  "has_ball"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["set_play_id"], name: "index_players_on_set_play_id"

  create_table "set_plays", force: true do |t|
    t.string   "name"
    t.integer  "offense_id"
    t.integer  "currentAF_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "set_plays", ["offense_id"], name: "index_set_plays_on_offense_id"

end
