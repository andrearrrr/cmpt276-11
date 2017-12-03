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

ActiveRecord::Schema.define(version: 20171128133446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.string "name"
    t.integer "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "picks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "player_id"
    t.integer "award_id"
    t.integer "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "league_id"
    t.boolean "is_private"
  end

  create_table "player_stats", force: :cascade do |t|
    t.integer "player_id"
    t.integer "season"
    t.integer "age"
    t.string "team"
    t.integer "games"
    t.integer "games_started"
    t.float "minutes"
    t.float "fg"
    t.float "fga"
    t.float "fgpct"
    t.float "fg3"
    t.float "fg3a"
    t.float "fg3pct"
    t.float "efgpct"
    t.float "ft"
    t.float "fta"
    t.float "ftpct"
    t.float "reboff"
    t.float "rebdef"
    t.float "rebtot"
    t.float "assists"
    t.float "steals"
    t.float "blocks"
    t.float "tovs"
    t.float "points"
    t.float "per"
    t.float "tspct"
    t.float "usage"
    t.float "obpm"
    t.float "dbpm"
    t.float "bpm"
    t.float "vorp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "identifier"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "PERSON_ID"
    t.string "DISPLAY_LAST_COMMA_FIRST"
    t.string "DISPLAY_FIRST_LAST"
    t.string "FROM_YEAR"
    t.string "TO_YEAR"
    t.string "PLAYERCODE"
    t.integer "TEAM_ID"
    t.string "TEAM_CITY"
    t.string "TEAM_NAME"
    t.string "TEAM_ABBREVIATION"
    t.string "TEAM_CODE"
    t.integer "AGE"
    t.string "PLAYER_HEIGHT"
    t.string "PLAYER_WEIGHT"
    t.string "COLLEGE"
    t.string "COUNTRY"
    t.string "DRAFT_YEAR"
    t.string "DRAFT_ROUND"
    t.string "DRAFT_NUMBER"
    t.float "PTS"
    t.float "REB"
    t.float "AST"
    t.float "NET_RATING"
    t.float "TS_PCT"
    t.float "USG_PCT"
    t.integer "GP"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "teamID"
    t.string "abbreviation"
    t.string "teamName"
    t.string "simpleName"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "league_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "posts", "users"
end
